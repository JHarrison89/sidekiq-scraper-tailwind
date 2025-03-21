# frozen_string_literal: true

class SavesController < ApplicationController
  layout "account"
  include JobUserCounter

  def index
    jobs = Current.user.jobs.where(job_users: { status: :saved })
    @grouped_jobs = GroupRecordsByDate.call(jobs)
  end

  def update
    @job = Job.find(params[:id])

    job_user = Current.user.job_users.find_or_create_by(job: @job)
    job_user.update(status: :saved)

    count_job_user_records

    @status = job_user.status.to_sym

    flash[:notice] = "Saved job"
  end
end
