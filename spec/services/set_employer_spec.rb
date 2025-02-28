# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SetEmployer do
  let(:logo_url) { 'http://example.com/logo.png' }

  before { allow(SetEmployerLogo).to receive(:call) }

  context 'when given the name of a new employer' do
    let(:name) { 'New Company inc' }

    it 'creates a Employer record' do
      expect { described_class.call(name:, logo_url:) }
        .to change(Employer, :count).by(1)
    end
  end

  context 'when given the name of an existing employer' do
    it 'does not create a Employer record' do
      name = Employer.create(name: 'Big Company inc').name

      expect { described_class.call(name:, logo_url:) }
        .to change(Employer, :count).by(0)
    end
  end
end
