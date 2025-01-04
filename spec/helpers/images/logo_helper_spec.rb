require 'rails_helper'

RSpec.describe LogoHelper, type: :helper do
  describe '#logo_helper' do
    it 'returns the correct image tag for a company with a logo' do
      expect(logo_helper(company_name: 'broadwick')).to eq("<img src=\"/images/app/assets/images/logos/broadwick.jpg\" />")
    end

    it 'returns the default image tag for a company without a logo' do
      expect(logo_helper(company_name: 'Unknown')).to eq("<img src=\"/images/app/assets/images/logos/default.jpg\" />")
    end
  end
end
