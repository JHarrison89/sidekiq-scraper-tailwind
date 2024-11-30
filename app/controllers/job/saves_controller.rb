class Job::SavesController < ApplicationController
  layout 'account'

  def index
    @jobs = Current.user.jobs.where(job_users: { status: :saved })
  end

  def create
    job = Job.find(params[:job_id])

    record = Current.user.job_users.find_or_create_by!(job:)
    record.update(status: :saved)
    flash[:notice] = 'Saved job'

    redirect_to job_path(job)
  end
end
