class TmpDatafile
  extend ActiveModel::Naming

  attr_accessor :task

  TMP_ROOT = Application.storage_manager.tmp_root

  # source file must exist
  # tmp file with this key must not exist
  # returns nil if preconditions not met

  def initialize(task)

    # validate
    source_root = Application.storage_manager.root_set.at(task.storage_root)
    return nil unless source_root

    source_file_exists = source_root.exist?(task.storage_key)
    return nil unless source_file_exists

    return nil if exist?

    TMP_ROOT.copy_content_to(task.tmp_key, source_root, task.storage_key)

    Problem.create("Tmp file not copied for task #{task.id}")

    return nil unless exist?

    self.task = task

  end

  def delete_if_exists
    TMP_ROOT.delete_content(self.tmp_key) if exist?
  end

  def exist?
    return TMP_ROOT.exist?(self.tmp_key)
  end

end