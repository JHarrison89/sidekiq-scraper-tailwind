# frozen_string_literal: true

class ScrapeShow
  include Sidekiq::Job

  def perform(id)
    record = JobShow.find(id)

    # Instantiate object
    script = Object.const_get(record.script)

    # Scrape webspage and return result
    attributes = script.call(record.url)

    # Early return if script return nil
    return if attributes.nil?

    # Find or create an employer
    employer = SetEmployer.call(
      name: attributes.employer,
      logo_url: attributes.logo_url
    )

    # Find or create a job
    SaveJob.call(employer:, attributes:)
  end
end
