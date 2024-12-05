class AccountsController < ApplicationController
  layout 'account'

  include DateSortable

  def show
    jobs = Job.all.where.not(id: associated_job_ids)
    @jobs = organize_by_date(jobs)

    flash[:notice] = 'Kiwis are tiny birds.'
  end

  private

  def associated_job_ids
    Current.user.job_users.map(&:job_id)
  end
end
