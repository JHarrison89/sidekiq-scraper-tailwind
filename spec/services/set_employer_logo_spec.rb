# frozen_string_literal: true

require "rails_helper"

RSpec.describe SetEmployerLogo do
  let(:logo_url) { "http://example.com/logo.png" }
  let(:fake_file) { StringIO.new("fake image data") }

  before do
    # Stub the network call to URI.open
    allow(URI).to receive(:open).with(logo_url).and_return(fake_file)
  end

  context "when employer has no logo attached" do
    it "attaches a logo" do
      employer = create(:employer)

      expect(employer.logo.attached?).to be_falsey

      SetEmployerLogo.call(employer:, logo_url:)

      expect(employer.logo.attached?).to be_truthy
    end
  end

  context "when the logo url is nil" do
    it "returns nil" do
      employer = create(:employer)
      logo_url = nil

      expect(SetEmployerLogo.call(employer:, logo_url:))
        .to be_nil
    end
  end

  context "when the employer has a logo" do
    it "returns nil" do
      employer = create(:employer, :with_logo)

      expect(described_class.call(employer:, logo_url:))
        .to be_nil
    end
  end
end
