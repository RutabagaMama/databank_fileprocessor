class MessageOut < ApplicationRecord

  def self.queue
    APP_CONFIG['messages']['outgoing_queue']
  end

  def send_message
    if self.content && self.content != ''
      AmqpConnector.instance.send_message(MessageOut.queue, self.content)
    else
      Problem.report("no content for MessageOut send: #{self.id}")
    end
  end

end
