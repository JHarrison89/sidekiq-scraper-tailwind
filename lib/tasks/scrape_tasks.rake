# frozen_string_literal: true

# lib/tasks/scraping.rake
require "platform-api"

# Centralize Heroku configuration
module HerokuConfig
  def self.client
    @client ||= PlatformAPI.connect_oauth(ENV["HEROKU_API_KEY"])
  end

  def self.app_name
    ENV["APP_NAME"]
  end
end

namespace :tasks do
  desc "Scrape index pages"
  task scrape_index_pages: :environment do
    IndexPages.constants.each do |index_page|
      Object.const_get("IndexPages::#{index_page}").call
    end
  end

  desc "Scrape show pages"
  task scrape_show_pages: :environment do
    job_urls = Job.all.pluck(:url)
    pages_to_scrape = JobShow.where.not(url: job_urls)
    pages_to_scrape.each { ScrapeShow.perform_async(_1.id) }
  end

  desc "Scale up worker"
  task scale_up_worker: :environment do
    HerokuConfig.client.formation.update(
      HerokuConfig.app_name,
      "worker",
      { quantity: 1 }
    )
  end

  desc "Scale down worker"
  task scale_down_worker: :environment do
    HerokuConfig.client.formation.update(
      HerokuConfig.app_name,
      "worker",
      { quantity: 0 }
    )
  end
end
