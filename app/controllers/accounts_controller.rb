# frozen_string_literal: true

class AccountsController < ApplicationController
  layout "account"

  include JobUserCounter

  def show
    # Filter saved and rejected jobs
    jobs = Job.includes(:employer).where.not(id: associated_job_ids)

    # Filter by employer_id is present
    jobs = jobs.where(employers: { id: filtered_params }) if filtered_params.present?

    @employers = jobs.map(&:employer).uniq

    # Groups jobs by created_at date
    @grouped_jobs = GroupRecordsByDate.call(jobs)

    respond_to do |format|
      # Use turbo_stream if filters are present
      if filtered_params.present?
        format.turbo_stream
      else
        format.html
      end
    end
  end

  private

  def permitted_params
    params.permit(employer_id: [])
  end

  def filtered_params
    return nil unless permitted_params[:employer_id].present?

    permitted_params[:employer_id].compact_blank
  end
end
