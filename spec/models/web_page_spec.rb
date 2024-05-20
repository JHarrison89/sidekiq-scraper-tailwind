# frozen_string_literal: true

require 'rails_helper'

RSpec.describe WebPage, type: :model do
  let(:web_page) { create(:WebPage, company: 'cool_company', url: 'site.com/job', script: 'script.rb') }

  it 'creates a web_page with attributes' do
    expect(web_page.company).to eq('cool_company')
    expect(web_page.url).to eq('site.com/job')
    expect(web_page.script).to eq('script.rb')
  end
end
