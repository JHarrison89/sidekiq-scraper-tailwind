class AddHtmlLocationEmployerToJobs < ActiveRecord::Migration[7.2]
  def change
    add_column :jobs, :employer, :string
    add_column :jobs, :location, :string
    add_column :jobs, :html_content, :text
  end
end
