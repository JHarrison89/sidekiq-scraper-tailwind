class RemoveEmployerFromJob < ActiveRecord::Migration[7.2]
  def change
    remove_column :jobs, :employer, :string
    rename_column :jobs, :company_name, :board
  end
end
