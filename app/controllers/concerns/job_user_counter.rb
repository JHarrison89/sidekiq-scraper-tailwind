module JobUserCounter
  extend ActiveSupport::Concern

  included do
    before_action :count_job_user_records, only: %i[index show]
  end

  private

  def count_job_user_records
    @available_count = Job.all.where.not(id: associated_job_ids).count
    @saved_count = Current.user.job_users.pluck(:status).count('saved')
    @rejected_count = Current.user.job_users.pluck(:status).count('rejected')
  end

  def associated_job_ids
    Current.user.job_users.map(&:job_id)
  end
end
