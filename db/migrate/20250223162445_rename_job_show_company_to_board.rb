class RenameJobShowCompanyToBoard < ActiveRecord::Migration[7.2]
  def change
    rename_column :job_shows, :company, :board
  end
end
