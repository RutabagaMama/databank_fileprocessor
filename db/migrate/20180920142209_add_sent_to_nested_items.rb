class AddSentToNestedItems < ActiveRecord::Migration[5.2]
  def change
    add_column :nested_items, :sent, :boolean, default: false
  end
end
