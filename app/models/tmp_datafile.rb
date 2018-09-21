require 'mime/types'
require 'os'
require 'zip'
require 'libarchive'

class TmpDatafile
  extend ActiveModel::Naming

  attr_accessor :task

  ALLOWED_CHAR_NUM = 1024 * 8
  ALLOWED_DISPLAY_BYTES = ALLOWED_CHAR_NUM * 8
  TMP_ROOT = Application.storage_manager.tmp_root

  # source file must exist
  # tmp file with this key must not exist
  # returns nil if preconditions not met

  def initialize(task)

    self.task = task

    # validate
    source_root = Application.storage_manager.root_set.at(task.storage_root)
    return nil unless source_root

    source_file_exists = source_root.exist?(task.storage_key)
    return nil unless source_file_exists

    if exist?
      Problem.report("failed attempt to overwrite file with key #{task.tmp_key} for task #{task.id}")
      return nil
    end

    TMP_ROOT.copy_content_to(task.tmp_key, source_root, task.storage_key)

    unless exist?
      Problem.report("failed attempt to copy file with key #{task.tmp_key} for task #{task.id}")
      nil
    end

  end

  # populate peek and nested_item tables
  # return true for success and false for failure
  def extract_features

    peek_type, peek_text = "none", ""

    mime_guess = top_level_mime || mime_from_filename(self.task.binary_name) || 'application/octet-stream'

    #Rails.logger.warn("#{self.task.binary_name} - #{mime_guess}")

    mime_parts = mime_guess.split("/")

    text_subtypes = ['csv', 'xml', 'x-sh', 'x-javascript', 'json', 'r', 'rb']

    nonzip_archive_subtypes = ['x-7z-compressed', 'x-tar']

    pdf_subtypes = ['pdf', 'x-pdf']

    microsoft_subtypes = ['msword',
                          'vnd.openxmlformats-officedocument.wordprocessingml.document',
                          'vnd.openxmlformats-officedocument.wordprocessingml.template',
                          'vnd.ms-word.document.macroEnabled.12',
                          'vnd.ms-word.template.macroEnabled.12',
                          'vnd.ms-excel',
                          'vnd.openxmlformats-officedocument.spreadsheetml.sheet',
                          'vnd.openxmlformats-officedocument.spreadsheetml.template',
                          'vnd.ms-excel.sheet.macroEnabled.12',
                          'vnd.ms-excel.template.macroEnabled.12',
                          'vnd.ms-excel.addin.macroEnabled.12',
                          'vnd.ms-excel.sheet.binary.macroEnabled.12',
                          'vnd.ms-powerpoint',
                          'vnd.openxmlformats-officedocument.presentationml.presentation',
                          'vnd.openxmlformats-officedocument.presentationml.template',
                          'vnd.openxmlformats-officedocument.presentationml.slideshow',
                          'vnd.ms-powerpoint.addin.macroEnabled.12',
                          'vnd.ms-powerpoint.presentation.macroEnabled.12',
                          'vnd.ms-powerpoint.template.macroEnabled.12',
                          'vnd.ms-powerpoint.slideshow.macroEnabled.12']

    subtype = mime_parts[1].downcase

    if mime_parts[0] == 'text' || text_subtypes.include?(subtype)
      return extract_text
    elsif mime_parts[0] == 'image'
      return extract_image
    elsif microsoft_subtypes.include?(subtype)
      return extract_microsoft
    elsif pdf_subtypes.include?(subtype)
      return extract_pdf
    elsif subtype == 'zip'
      return extract_zip
    elsif nonzip_archive_subtypes.include?(subtype)
      return extract_archive
    else
      return extract_default
    end

  end
  
  def task_cancelled?
    cancel_tasks = Task.where(operation: 'cancel', datafile_id: self.task.datafile_id).where("created_at > #{self.task.created_at}")
    cancel_tasks.count > 0
  end

  def delete_tree
    TMP_ROOT.delete_tree(self.task.tmp_key) if exist?
  end

  def exist?
    if self.task && self.task.tmp_key
      TMP_ROOT.exist?(self.task.tmp_key)
    else
      false
    end
  end

  def storage_path
    # this works because the tmp root is always a filesystem
    root_path = Application.storage_manager.tmp_root.path
    File.join(root_path, self.task.tmp_key)
  end

  def top_level_mime
    TmpDatafile.mime_from_path(self.storage_path)
  end

  def self.mime_from_path(path)
    file_mime_response = `file --mime -b "#{path}"`
    if file_mime_response
      response_parts = file_mime_response.split(";")
      return response_parts[0]
    else
      nil
    end
  end

  def self.mime_from_filename(filename)
    mime_guesses = MIME::Types.type_for(filename).first.content_type
    if mime_guesses.length > 0
      mime_guesses.first.content_type
    else
      nil
    end
  end

  def extract_text
    #Rails.logger.warn("inside extract_text")
    begin
    num_bytes = File.size?(self.storage_path)
      if num_bytes > ALLOWED_DISPLAY_BYTES
        enc = TmpDatafile.charset_from_path(self.storage_path) ||'UTF-8'
        peek_text = ""
        File.open(self.storage_path, 'r', encoding: enc).each do |line|
          peek_text << line
          if peek_text.length > ALLOWED_CHAR_NUM
            create_peek('part_text', peek_text)
            return true
          end
        end
      else
        create_peek('full_text', File.read(self.storage_path, encoding: enc))
        return true
      end
    rescue StandardError => ex
      create_peek('none','')
      Problem.report("Problem extracting text for task #{self.task.id}: #{ex.message}")
      return false
    end
  end

  def extract_image
    #Rails.logger.warn("inside extract_image")
    begin
      create_peek('image', '')
      return true
    rescue StandardError => ex
      create_peek('none', '')
      Problem.report("Problem extracting image for task #{self.task.id}: #{ex.message}")
      return false
    end
  end

  def extract_microsoft
    #Rails.logger.warn("inside extract_microsoft")
    begin
      create_peek('microsoft', '')
      return true
    rescue StandardError => ex
      Problem.report("Problem extracting microsoft for task #{self.task.id}: #{ex.message}")
      return false
    end
  end

  def extract_pdf
    #Rails.logger.warn("inside extract_pdf")
    begin
      create_peek('pdf', '')
      return true
    rescue StandardError => ex
      Problem.report("Problem extracting pdf for task #{self.task.id}: #{ex.message}")
      return false
    end
  end

  def extract_zip
    #Rails.logger.warn("inside extract_zip")
    begin
      entry_paths = []
      Zip::File.open(self.storage_path) do |zip_file|
        zip_file.each do |entry|
          if entry.name_safe?
            entry_path = valid_entry_path(entry.name)

            if entry_path && !is_ds_store(entry_path) && !is_mac_thing(entry_path)
              entry_paths << entry_path
              create_item(entry_path, name_part(entry_path), entry.size, is_directory(entry_path))
            end
          end
        end
      end

      if entry_paths.length > 0
        create_peek('listing', entry_paths_arr_to_html(entry_paths))
      else
        Problem.report("no items found for zip listing for task #{self.task.id}")
        create_peek('none', '')
      end

      return true
    rescue StandardError => ex
      Problem.report("problem extracting zip listing for task #{self.task.id}: #{ex.message}")
      raise ex
      #return false
    end
  end

  def extract_archive
    #Rails.logger.warn("inside extract_archive")
    begin

      entry_paths = []

      Archive.read_open_filename('foo.tar.gz') do |ar|
        while entry = ar.next_header

          entry_path = valid_entry_path(entry.pathname)
          if entry_path
            entry_paths << entry_path
            entry_size = 0
            ar.read_data(1024) do |x|
              put x.class
              entry_size = entry_size + x.length
            end
            create_item(entry_path, name_part(entry_path), entry_size, is_directory(entry_path))
          end
        end
      end

      if entry_paths.length > 0
        create_peek('listing', entry_paths_arr_to_html(entry_paths))
        return true
      else
        Problem.report("no items found for archive listing for task #{self.task.id}")
        create_peek('none', '')
        return false
      end

    rescue StandardError => ex
      Problem.report("problem extracting extract listing for task #{self.task.id}: #{ex.message}")
      return false
    end
  end

  def extract_default
    #Rails.logger.warn("inside extract_default")
    begin
      create_peek('none', '')
      return true
    rescue StandardError => ex
      Problem.report("problem creating default peek for task #{self.task.id}")
      return false
    end
  end

  def valid_entry_path(entry_path)
    if entry_path[-1] == '/'
      return entry_path[0...-1]
    elsif entry_path.length > 0
      return entry_path
    end
  end

  def is_directory(path)
    ends_in_slash(path) && !is_ds_store(path) && !is_mac_thing(path)
  end

  def is_mac_thing(path)
    entry_parts = path.split('/')
    entry_parts.include?('__MACOSX')
  end

  def ends_in_slash(path)
    return path[-1] == '/'
  end

  def is_ds_store(path)
    name_part(path).strip() == '.DS_Store'
  end

  def name_part(path)
    valid_path = valid_entry_path(path)
    if valid_path
      entry_parts = valid_path.split('/')
      if entry_parts.length > 1
        entry_parts[-1]
      else
        valid_path
      end
    end
  end

  def self.charset_from_path(path)

    file_info = ""

    if OS.mac?
      file_info = `file -I #{path}`
    elsif OS.linux?
      file_info = `file -i #{path}`
    else
      return nil
    end

    if file_info.length > 0
      file_info.strip.split('charset=').last
    else
      nil
    end
  end

  def entry_paths_arr_to_html(entry_paths)
    return_string = '<span class="glyphicon glyphicon-folder-open"></span> '

    return_string << self.task.binary_name

    entry_paths.each do |entry_path|

      if entry_path.exclude?('__MACOSX') && entry_path.exclude?('.DS_Store')

        name_arr = entry_path.split("/")

        name_arr.length.times do
          return_string << "<div class='indent'>"
        end

        if entry_path[-1] == "/" # means directory
          return_string << '<span class="glyphicon glyphicon-folder-open"></span> '

        else
          return_string << '<span class="glyphicon glyphicon-file"></span> '
        end

        return_string << name_arr.last
        name_arr.length.times do
          return_string << "</div>"
        end
      end

    end

    return return_string

  end

  def create_peek(peek_type, peek_text)
    Peek.create(task_id: self.task.id,
                datafile_id: self.task.datafile_id,
                peek_type: peek_type,
                peek_text:peek_text )
  end

  def create_item(path, name, size, is_directory)
    NestedItem.create(task_id: self.task.id,
                      dataset_id: self.task.dataset_id,
                      datafile_id: self.task.datafile_id,
                      item_path: path,
                      item_name: name,
                      size: size,
                      is_directory: is_directory)

  end

end