# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Account show" do
  it "groups jobs by created_at and lists them correctly", :js do
    # Friday 2024, January 31st
    travel_to Time.zone.local(2025, 1, 31)

    create(:user)

    # We only asset the Employer name in the first within job list block
    job_1 = create(:job, title: "Job 1", created_at: Date.today)
    create(:job, title: "Job 2", created_at: 1.day.ago)
    create(:job, title: "Job 3", created_at: 2.day.ago)
    create(:job, title: "Job 4", created_at: Date.today.beginning_of_week)
    create(:job, title: "Job 5", created_at: Date.today.beginning_of_week)
    create(:job, title: "Job 6", created_at: Date.today.last_week)
    create(:job, title: "Job 7", created_at: Date.today.last_week)
    create(:job, title: "Job 8", created_at: Date.today.last_week)
    create(:job, title: "Job 9", created_at: Date.today.weeks_ago(2))
    create(:job, title: "Job 10", created_at: Date.today.weeks_ago(2))
    create(:job, title: "Job 11", created_at: Date.today.weeks_ago(3))
    create(:job, title: "Job 12", created_at: Date.today.weeks_ago(3))
    create(:job, title: "Job 13", created_at: Date.today.weeks_ago(4))
    create(:job, title: "Job 14", created_at: Date.today.weeks_ago(4))
    create(:job, title: "Job 15", created_at: (Date.today << 1).beginning_of_month)
    create(:job, title: "Job 16", created_at: (Date.today << 2).beginning_of_month)
    create(:job, title: "Job 17", created_at: (Date.today << 3).beginning_of_month)

    visit sign_in_path

    expect(page).to have_content("Sign in to your account")
    fill_in "Email", with: "example@email.com"
    fill_in "Password", with: "Password123@"

    click_button "Sign in"

    expect(page).to have_content("A list of all the job posts from our list of job sites.")

    within ".job-list", text: "Posted today" do
      expect(page).to have_text("Job 1")
      expect(page).to have_text(job_1.employer.name)
    end

    within ".job-list", text: "Posted yesterday" do
      expect(page).to have_text("Job 2")
    end

    within ".job-list", text: "Posted earlier this week" do
      expect(page).to have_text("Job 3")
      expect(page).to have_text("Job 4")
      expect(page).to have_text("Job 5")
    end

    within ".job-list", text: "Posted last week" do
      expect(page).to have_text("Job 6")
      expect(page).to have_text("Job 7")
      expect(page).to have_text("Job 8")
    end

    within ".job-list", text: "Posted two weeks ago" do
      expect(page).to have_text("Job 9")
      expect(page).to have_text("Job 10")
    end

    within ".job-list", text: "Posted three weeks ago" do
      expect(page).to have_text("Job 11")
      expect(page).to have_text("Job 12")
    end

    within ".job-list", text: "Posted four weeks ago" do
      expect(page).to have_text("Job 13")
      expect(page).to have_text("Job 14")
    end

    within ".job-list", text: "Posted last month" do
      expect(page).to have_text("Job 15")
    end

    within ".job-list", text: "Posted two months ago" do
      expect(page).to have_text("Job 16")
    end

    within ".job-list", text: "Posted three months ago" do
      expect(page).to have_text("Job 17")
    end
  end
end
