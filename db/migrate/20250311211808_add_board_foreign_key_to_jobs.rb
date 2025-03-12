class AddBoardForeignKeyToJobs < ActiveRecord::Migration[7.2]
  def change
    remove_column :jobs, :board, :string
    add_reference :jobs, :board, null: true, foreign_key: true
  end
end
