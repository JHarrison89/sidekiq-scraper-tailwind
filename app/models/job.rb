class Job < ApplicationRecord
  has_many :job_users  # Association with the join table
  has_many :users, through: :job_users # Many-to-many association through JobUser
end
