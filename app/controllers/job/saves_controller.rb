class Job::SavesController < ApplicationController
  def create
    job = Job.find(params[:job_id])

    begin
      Current.user.job_users.create!(job:)
      flash[:notice] = 'Job saved!'
    rescue ActiveRecord::RecordInvalid
      flash[:alert] = 'Failed to save job'
    end

    redirect_to job_path(job)
  end

  def destroy
    job = Job.find(params[:job_id])
    current_user.unsave_job(job)
    redirect_to job_path(job)
  end
end
