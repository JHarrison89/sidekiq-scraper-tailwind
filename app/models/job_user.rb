class JobUser < ApplicationRecord
  belongs_to :user
  belongs_to :job

  validates :user_id, uniqueness: { scope: :job_id, message: "has already been assigned to this job" }
end
