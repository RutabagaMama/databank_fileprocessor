class NestedItem < ApplicationRecord

  belongs_to :task

  def self.send_messages
    new_items = NestedItem.where(sent: false)
    if new_items.count > 0
      new_items.each(&:send_message)
    end
  end

  def send_message
    msg_hash = Hash.new
    msg_hash[:operation] = "NestedItem.add"
    msg_hash[:dataset_id] = self.dataset_id
    msg_hash[:datafile_id] = self.datafile_id
    msg_hash[:item_path] = self.item_path
    msg_hash[:item_name] = self.item_name
    msg_hash[:size] = self.size
    msg_hash[:is_directory] = self.is_directory
    msg_hash[:task_id] = self.task.id
    msg = MessageOut.create(content: msg_hash.to_json)
    msg.send_message
    self.sent = true
    self.save
  end
end
