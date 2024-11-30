class JobUser < ApplicationRecord
  belongs_to :user
  belongs_to :job

  enum :status, [:saved, :rejected]

  validates :user_id, uniqueness: { scope: :job_id, message: "has already been assigned to this job" }
end
