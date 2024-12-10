
require 'rails_helper'

RSpec.describe 'Job list' do
  let(:user) { create(:user) }

  let(:first_job) { create(:job, title: 'Job 1', created_at: 1.day.ago) }
  let(:second_job) { create(:job, title: 'Job 1', created_at: 2.day.ago) }
  let(:third_job) { create(:job, title: 'Job 1', created_at: 3.day.ago) }
  let(:fourth_job) { create(:job, title: 'Job 1', created_at: 4.day.ago) }
  let(:fifth_job) { create(:job, title: 'Job 1', created_at: 5.day.ago) }

  before { user }

  it 'groups jobs by created_at and lists them correctly', :js do
    first_job

    visit sign_in_path

    expect(page).to have_content('Sign in to your account')
    fill_in 'Email', with: 'example@email.com'
    fill_in 'Password', with: 'Password123@'

    click_button 'Sign in'

    expect(page).to have_content('A list of all the job posts from our list of job sites.')

    within(".job-list") do
      expect(find('p').text).to eq 'Posted 10 days ago'
    end
  end
end
