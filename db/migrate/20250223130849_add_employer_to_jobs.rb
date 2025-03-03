class AddEmployerToJobs < ActiveRecord::Migration[7.2]
  def change
    add_reference :jobs, :employer, null: true, foreign_key: true
  end
end
