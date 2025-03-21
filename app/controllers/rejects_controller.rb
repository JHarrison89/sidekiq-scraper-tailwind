# frozen_string_literal: true

class RejectsController < ApplicationController
  layout "account"
  include JobUserCounter

  def index
    jobs = Current.user.jobs.where(job_users: { status: :rejected })
    @grouped_jobs = GroupRecordsByDate.call(jobs)
  end

  def update
    @job = Job.find(params[:id])

    job_user = Current.user.job_users.find_or_create_by(job: @job)
    job_user.update(status: :rejected)

    count_job_user_records

    @status = job_user.status.to_sym

    flash[:notice] = "Rejected job"
  end
end
