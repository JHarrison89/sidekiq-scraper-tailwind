class CreateWebPages < ActiveRecord::Migration[7.0]
  def change
    create_table :web_pages do |t|
      t.string :company, null: false
      t.string :url, null: false
      t.string :script, null: false
      t.timestamps
    end
  end
end
