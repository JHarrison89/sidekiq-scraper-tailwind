class AccountsController < ApplicationController
  layout 'account'

  def show
    jobs = Job.all.where.not(id: associated_job_ids)
    jobs = jobs.all.group_by { _1.created_at.to_date }
    @jobs = jobs.sort_by { |key, _| key }.reverse

    flash[:notice] = 'Kiwis are tiny birds.'
  end

  private

  def associated_job_ids
    Current.user.job_users.map(&:job_id)
  end
end
