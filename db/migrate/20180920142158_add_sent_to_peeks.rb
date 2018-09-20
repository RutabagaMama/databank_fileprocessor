class AddSentToPeeks < ActiveRecord::Migration[5.2]
  def change
    add_column :peeks, :sent, :boolean, default: false
  end
end
