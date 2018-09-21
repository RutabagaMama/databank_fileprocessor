class Peek < ApplicationRecord

  belongs_to :task

  def self.send_messages
    new_peeks = Peek.where(sent: false)
    if new_peeks.count > 0
      new_peeks.each(&:send_message)
    end
  end

  def send_message

    msg_hash = Hash.new
    msg_hash[:operation] = "Peek.add"
    msg_hash[:datafile_id] = self.datafile_id
    msg_hash[:peek_type] = self.peek_type
    msg_hash[:peek_text] = self.peek_text
    msg_hash[:task_id] = self.task_id

    msg = MessageOut.create(content: msg_hash.to_json)
    msg.send_message
    self.sent = true
    self.save
  end
end
