class AddTimesToTasks < ActiveRecord::Migration[5.2]
  def change
    add_column :tasks, :start_time, :datetime
    add_column :tasks, :end_time, :datetime
    add_column :tasks, :handled, :boolean, default: false
  end
end
