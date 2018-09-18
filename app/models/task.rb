class Task < ApplicationRecord

  def self.handle_new_tasks

    new_tasks = Task.where(start_time: nil)

    # claim and mark
    new_tasks.each do |task|
      task.start_time = Time.now
      task.save
    end

    new_tasks.each do |task|
      task.handle
    end

  end


  def handle
    if self.operation && self.operation != ''
      if self.operation == 'process'
        self.process
      elsif self.operation == 'cancel'
        self.cancel
      else
        Problem.create("invalid operation for task #{task.id}")
      end
    else
      Problem.create("no operation for task #{self.id}.")
    end
  end


  def process
    tmp_datafile = TmpDatafile.create(self)
    tmp_datafile.generate_peeks_items
    tmp_datafile.delete_if_exists
    self.stop_time = Time.now
    self.save
  end

  def cancel
    mark_tasks
    remove_file
  end

  def mark_tasks

  end

  #TODO handle file is being processed
  def delete_file_if_exists
    if Application.storage_manager.tmp_root.exist(tmp_key)
      Application.storage_manager.tmp_root.delete_content(tmp_key)
    end
  end

  def tmp_key
    File.join("task_#{self.id}", self.binary_name)
  end

  def current_root
    if self.storage_root == 'draft'
      return Application.storage_manager.draft_root
    elsif self.storage_root == 'medusa'
      return Application.storage_root.medusa_root
    else
      return nil
    end
  end

end
