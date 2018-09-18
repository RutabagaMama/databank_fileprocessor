class CreateTasks < ActiveRecord::Migration[5.2]
  def change
    create_table :tasks do |t|
      t.string :operation
      t.integer :dataset_id, limit: 4
      t.integer :datafile_id, limit: 4
      t.string :storage_root
      t.string :storage_key
      t.string :binary_name

      t.timestamps
    end
  end
end
