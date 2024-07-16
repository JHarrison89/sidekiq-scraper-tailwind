# frozen_string_literal: true

# Queues up a
class ScrapeShowPageJob
  include Sidekiq::Job

  def perform(script:, url:)
    # Instantiate object
    script = Object.const_get(script)

    # Scrape webspage and return result
    attributes = script.call(url:)

    # Find or create job record
    SaveJob.call(attributes)
  end
end
