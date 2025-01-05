class Job::RejectsController < ApplicationController
  layout 'account'

  include DateSortable

  def index
    jobs = Current.user.jobs.where(job_users: { status: :rejected })
    @jobs = RecordGrouper.call(jobs)
  end

  def update
    job = Job.find(params[:job_id])
    record = Current.user.job_users.find_or_create_by(job:)
    record.update(status: :rejected)
    flash[:notice] = 'Rejected job'

    redirect_to job_path(job)
  end
end
