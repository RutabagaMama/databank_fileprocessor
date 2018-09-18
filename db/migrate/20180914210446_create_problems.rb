class CreateProblems < ActiveRecord::Migration[5.2]
  def change
    create_table :problems do |t|
      t.text :report
      t.text :notes
      t.boolean :resolved

      t.timestamps
    end
  end
end
