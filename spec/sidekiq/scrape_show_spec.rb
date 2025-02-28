# frozen_string_literal: true

require 'rails_helper'
require 'sidekiq/testing'

# Stubs a job page script thats
# custom designed to scrape the
# show page of a site
# e.g doorsopen.com
class ShowPageScript
  def self.call(url); end
end

# Tests the show page job. The call to the
# show page script is stubs to avoid calling
# out to a real website.
RSpec.describe ScrapeShow, type: :job do
  include ActiveSupport::Testing::TimeHelpers

  describe '#perform' do
    let(:attributes) {
      OpenStruct.new(
        board: 'Job Board',
        url: 'www.exmaple.com',
        title: 'Ticketing Manager',
        location: 'London',
        html_content: '<p>Hello World</p>',
        employer: 'Big Company inc'
      )
    }

    let(:script) { ShowPageScript }
    let(:job_show) { create(:JobShow) }

    before { allow(script).to receive(:call).and_return(attributes) }

    context 'when given attributes of a job' do
      it 'creates a new job record if the URL is new' do
        expect { subject.perform(job_show.id) }
          .to change(Job, :count).by(1)

        expect(Job.last).to have_attributes(
          board: attributes.board,
          url: attributes.url,
          title: attributes.title,
          location: attributes.location,
          html_content: attributes.html_content,
          employer: have_attributes(
            name: attributes.employer
          )
        )
      end

      it 'finds and updates the job if the URL belongs a job' do
        Job.create(
          board: 'job record',
          title: 'that exists already',
          url: 'www.exmaple.com',
          employer:
          create(
            :employer,
            name: 'Big Company inc'
          )
        )

        expect { subject.perform(job_show.id) }
          .to change(Job, :count).by(0)
      end
    end

    context 'when given the name an employer' do
      it 'create a new Employer record if it does not exist' do
        expect { subject.perform(job_show.id) }
          .to change(Employer, :count).by(1)
      end

      it 'does not create an Employer record if it does exist' do
        Employer.create(name: 'Big Company inc')

        expect { subject.perform(job_show.id) }
          .to change(Employer, :count).by(0)
      end
    end
  end
end
