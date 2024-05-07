class CreateJobs < ActiveRecord::Migration[7.0]
  def change
    create_table :jobs do |t|
      t.string :company_name
      t.string :title
      t.string :url

      t.timestamps
    end
  end
end
