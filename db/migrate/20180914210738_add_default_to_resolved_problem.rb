class AddDefaultToResolvedProblem < ActiveRecord::Migration[5.2]
  def change
    change_column_default(:problems, :resolved, false)
  end
end
