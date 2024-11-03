class CreateJobUsers < ActiveRecord::Migration[7.2]
  def change
    create_table :job_users do |t|
      t.references :user, null: false, foreign_key: true
      t.references :job, null: false, foreign_key: true

      t.timestamps
    end

    add_index :job_users, [:user_id, :job_id], unique: true
  end
end
