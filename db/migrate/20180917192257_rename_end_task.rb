class RenameEndTask < ActiveRecord::Migration[5.2]
  def change
    rename_column :tasks, :end_time, :stop_time
  end
end
