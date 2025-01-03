class AccountsController < ApplicationController
  layout 'account'

  include DateSortable

  def show
    jobs = Job.all
    @jobs = RecordGrouper.call(jobs)

    flash[:notice] = 'Kiwis are tiny birds.'
  end

  private

  def associated_job_ids
    Current.user.job_users.map(&:job_id)
  end
end
