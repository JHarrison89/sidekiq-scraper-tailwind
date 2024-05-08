# frozen_string_literal: true

# queues up a job for each
# Scraper record
class ScrapeJob
  include Sidekiq::Job

  def perform(*args)
    # Do something
  end
end
