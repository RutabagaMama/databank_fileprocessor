class CreateMessageOuts < ActiveRecord::Migration[5.2]
  def change
    create_table :message_outs do |t|
      t.text :content

      t.timestamps
    end
  end
end
