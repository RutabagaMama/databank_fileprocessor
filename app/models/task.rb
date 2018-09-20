class Task < ApplicationRecord

  attr_accessor :tmp_datafile

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
        Problem.report("invalid operation for task #{task.id}")
      end
    else
      Problem.report("no operation for task #{self.id}")
    end
  end

  def process
    self.tmp_datafile = TmpDatafile.new(self)

    if self.tmp_datafile
      success = self.tmp_datafile.extract_features
      self.stop_time = Time.now
      self.handled = success
      self.save
    end

  end

  def cancel
    target_tasks = Task.where(datafile_id: self.datafile_id)
    if target_tasks.count < 0
      self.stop_time = Time.now
      self.handled = false
      Problem.report("no task found to cancel for task #{self.id}")
    else
      target_tasks.each do |task|
        if task.stop_time && task.stop_time > Time.now
          # too late to cancel processing, but may be able to stop messages
          self.stop_time = Time.now
          self.handled = true
          # else wait for processing task to mark the cancel task stopped and handled
        end
      end
    end
    self.save
  end

  def tmp_key
    File.join("task_#{self.id}", self.binary_name)
  end

end
