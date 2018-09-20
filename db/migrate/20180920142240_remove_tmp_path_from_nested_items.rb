class RemoveTmpPathFromNestedItems < ActiveRecord::Migration[5.2]
  def change
    remove_column :nested_items, :tmp_path
  end
end
