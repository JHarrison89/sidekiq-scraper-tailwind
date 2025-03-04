# frozen_string_literal: true

# spec/tasks/scrape_show_pages_rake_spec.rb
require "rails_helper"
require "rake"


# Tests the scrape_show_pages rake task functionality
RSpec.describe "scrape_tasks:scrape_show_pages", type: :task do
  before :all do
    Rake.application.rake_require("tasks/scrape_tasks")
    Rake::Task.define_task(:environment)
  end

  let(:task) { Rake::Task["scrape_tasks:scrape_show_pages"] }

  before do
    task.reenable # Allows the task to be re-run in the same spec
  end

  describe "scrape_show_pages" do
    # Show page records
    let!(:job_show1) { create(:JobShow, url: "https://example.com/job1") }
    let!(:job_show2) { create(:JobShow, url: "https://example.com/job2") }
    let!(:job_show3) { create(:JobShow, url: "https://example.com/job3") }


    # Persisted Job records
    let!(:job1) { create(:job, url: "https://example.com/job1") }
    let!(:job2) { create(:job, url: "https://example.com/job2") }

    it "enqueues ScrapeShow for JobShow records not saved as Job" do
      expect(ScrapeShow).to receive(:perform_async).with(job_show3.id).once

      task.invoke
    end

    it "does not enqueue if JobShow URL has been saved as Job" do
      expect(ScrapeShow).not_to receive(:perform_async).with(job_show1.id)
      expect(ScrapeShow).not_to receive(:perform_async).with(job_show2.id)

      task.invoke
    end
  end
end
