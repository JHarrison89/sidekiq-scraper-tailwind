# frozen_string_literal: true

require 'rails_helper'
require 'sidekiq/testing'

# Stubs a job page script thats
# custom designed to scrape the
# show page of a site
# e.g doorsopen.com
class JobShowPageScript
  def self.call(url:); end
end

# Tests the show page job. The call to the
# show page script is stubs to avoid calling
# out to a real website.
RSpec.describe ScrapeJobShowJob, type: :job do
  include ActiveSupport::Testing::TimeHelpers

  describe '#perform' do
    let(:url) { 'https://www.example.com' }
    let(:attributes) { OpenStruct.new(company_name: 'NVS', title: 'Ticketing Manager', url:) }
    let(:script) { JobShowPageScript }

    before { allow(script).to receive(:call).and_return(attributes) }

    context 'when given attributes of a new job' do
      it 'creates a new job record' do
        expect { subject.perform(script: script.name, url:) }
          .to change(Job, :count).by(1)

        expect(Job.last).to have_attributes(
          company_name: attributes.company_name,
          title: attributes.title,
          url: attributes.url
        )
      end

      describe 'when give attributes of an existing job' do
        it 'finds and updates the job' do
          travel_to(1.month.ago)
          Job.create(company_name: 'job record', title: 'that exists already', url:)
          travel_back

          expect { subject.perform(script: script.name, url:) }
            .to change(Job, :count).by(0)
        end
      end
    end
  end
end
