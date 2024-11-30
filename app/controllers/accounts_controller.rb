class AccountsController < ApplicationController
  layout 'account'

  def show
    @jobs = Job.all.where.not(id: associated_job_ids)
    flash[:notice] = 'Kiwis are tiny birds.'
  end

  private

  def associated_job_ids
    Current.user.job_users.map(&:job_id)
  end
end
