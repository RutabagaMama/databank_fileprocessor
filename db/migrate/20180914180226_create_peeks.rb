class CreatePeeks < ActiveRecord::Migration[5.2]
  def change
    create_table :peeks do |t|
      t.integer :task_id
      t.integer :datafile_id, limit: 4
      t.string :peek_type
      t.text :peek_text

      t.timestamps
    end
  end
end
