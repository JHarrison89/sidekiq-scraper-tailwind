# frozen_string_literal: true

require "rails_helper"
require "sidekiq/testing"

# Stubs a job page script thats
# custom designed to scrape the
# show page of a site
# e.g doorsopen.com
class ShowPageScript
  def self.call(url, sleep_time); end
end

# Tests the show page job. The call to the
# show page script is stubs to avoid calling
# out to a real website.
#
# TODO: Update test to include sleep_time argument
RSpec.describe ScrapeShow, type: :job do
  include ActiveSupport::Testing::TimeHelpers

  describe "#perform" do
    let(:script) { ShowPageScript }
    let(:job_show) { create(:JobShow) }

    # Unpersisted job record, persisted employer and board.
    # Here we assume that the employer and board are already exist.
    let(:job) { build(:job, employer: create(:employer, :with_logo), board: create(:board, :with_logo)) }

    let(:attributes) do
      OpenStruct.new(
        url: job.url,
        title: job.title,
        location: job.location,
        html_content: job.html_content,
        logo_url: "http://example.com/logo.png",
        employer: job.employer.name,
        board: job.board.name
      )
    end

    let(:logo_url) { "http://example.com/logo.png" }
    let(:fake_file) { StringIO.new("fake image data") }

    before do
      # Stub the call to Script
      allow(script).to receive(:call).and_return(attributes)

      # Stub the network call to URI.open
      allow(URI).to receive(:open).with(logo_url).and_return(fake_file)
    end

    context "when given attributes of a job" do
      it "creates a new job record if the URL does not belong to a job" do
        expect { subject.perform(job_show.id, 10) }
          .to change(Job, :count).by(1)

        expect(Job.last).to have_attributes(
          title: job.title,
          location: job.location,
          html_content: job.html_content,
          url: job.url,
          employer: job.employer,
          board: job.board
        )
      end

      it "updates the job if the URL belongs an existing job" do
        # Persisted job record
        create(:job)

        expect { subject.perform(job_show.id) }
          .to change(Job, :count).by(0)
      end
    end
  end
end
