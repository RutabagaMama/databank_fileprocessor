class CreateNestedItems < ActiveRecord::Migration[5.2]
  def change
    create_table :nested_items do |t|
      t.integer :task_id
      t.integer :dataset_id, limit: 4
      t.integer :datafile_id, limit: 4
      t.string :tmp_path
      t.string :item_path
      t.string :item_name
      t.integer :size, limit: 8
      t.boolean :is_directory

      t.timestamps
    end
  end
end
