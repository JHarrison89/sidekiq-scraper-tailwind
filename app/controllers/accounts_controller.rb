class AccountsController < ApplicationController
  layout 'account'

  include DateSortable

  def show
    jobs = Job.all.where.not(id: associated_job_ids)
    @jobs = RecordGrouper.call(jobs)

    @all_jobs_total = @jobs.count
    @saved_jobs_count = 5
    @rejected_jobs_count = 5
  end

  private

  def associated_job_ids
    Current.user.job_users.map(&:job_id)
  end
end
