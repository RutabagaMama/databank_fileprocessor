class Peek < ApplicationRecord
  def self.send_messages
    Rails.logger.warn("inside Peek.send_messages")
  end
end
