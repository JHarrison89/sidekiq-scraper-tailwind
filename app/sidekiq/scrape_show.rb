# frozen_string_literal: true

class ScrapeShow
  include Sidekiq::Job

  def perform(id, sleep_time = 200)
    record = JobShow.find(id)

    # Instantiate object
    script = Object.const_get(record.script)

    # Scrape webpage and return result
    attributes = script.call(record.url, sleep_time)

    # Early return if script return nil
    return if attributes.nil?

    # Find or create an employer
    employer = SetEmployer.call(
      name: attributes.employer,
      logo_url: attributes.logo_url
    )

    # Find or create a board
    board = SetBoard.call(
      name: attributes.board
    )

    # Find or create a job
    SaveJob.call(employer:, board:, attributes:)
  end
end
