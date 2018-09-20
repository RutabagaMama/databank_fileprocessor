class NestedItem < ApplicationRecord
  def self.send_messages
    Rails.logger.warn("inside NestedItems.send_messages")
  end
end
