# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SaveJob, type: :model do
  let(:attributes) { OpenStruct.new(company_name: 'NVS', title: 'Ticketing Manager', url: 'doorsopen/first_job') }
  describe 'when given new attributes' do
    it 'creates a new job' do
      expect { described_class.call(attributes) }
        .to change(Job, :count).by(1)
    end
  end

  describe 'when given existing attributes' do
    before { Job.create(company_name: 'job record', title: 'that exists already', url: 'doorsopen/first_job') }
    it 'does not create a new job' do
      expect { described_class.call(attributes) }
        .to change(Job, :count).by(0)
    end
  end
end
