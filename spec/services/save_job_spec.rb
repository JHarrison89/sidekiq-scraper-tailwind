# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SaveJob, type: :model do
  let(:attributes) { OpenStruct.new(board: 'Job Board', url: 'doorsopen/first_job', title: 'Ticketing Manager', employer: create(:employer), location: "London", html_content: "<p>Hello World</p>") }
  describe 'when given new attributes' do
    it 'creates a new job' do
      expect { described_class.call(attributes) }
        .to change(Job, :count).by(1)
    end
  end

  describe 'when given existing attributes' do
    before { Job.create(board: 'Job Board', url: 'doorsopen/first_job', title: 'Ticketing Manager', employer: create(:employer), location: "London", html_content: "<p>Hello World</p>") }
    it 'does not create a new job' do
      expect { described_class.call(attributes) }
        .to change(Job, :count).by(0)
    end
  end
end
