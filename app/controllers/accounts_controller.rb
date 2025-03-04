# frozen_string_literal: true

class AccountsController < ApplicationController
  layout "account"

  include JobUserCounter

  def show
    jobs = Job.all.where.not(id: associated_job_ids)
    @jobs = RecordGrouper.call(jobs)
  end
end
