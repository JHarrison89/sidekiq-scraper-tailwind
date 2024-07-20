# frozen_string_literal: true

# A job show page record
class CreateJobShows < ActiveRecord::Migration[7.0]
  def change
    create_table :job_shows do |t|
      t.string :company
      t.string :url
      t.string :script

      t.timestamps
    end
  end
end
