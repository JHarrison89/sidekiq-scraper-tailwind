# frozen_string_literal: true

require 'rails_helper'
require 'sidekiq/testing'

RSpec.describe ScrapeJob, type: :job do
  it 'enqueues a job' do
    expect { ScrapeJob.perform_async }
      .to change(ScrapeJob.jobs, :size).by(1)
  end
end
