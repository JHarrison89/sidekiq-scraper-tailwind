# frozen_string_literal: true

require "rails_helper"

RSpec.describe GroupRecordsByDate, type: :model do
  let(:grouped_records) { described_class.call(Job.all) }

  it "groups records created today" do
    job = create(:job, created_at: Date.today)

    expect(grouped_records[:today].count).to eq(1)
    expect(grouped_records[:today]).to contain_exactly(job)
  end

  it "groups records created yesterday" do
    create(:job, created_at: Date.today)
    job = create(:job, created_at: 1.day.ago)

    expect(grouped_records[:yesterday].count).to eq(1)
    expect(grouped_records[:yesterday]).to contain_exactly(job)
  end

  context "when given records created on Monday, Tuesday or Wednesday this week" do
    it "groups the records into earlier_this_week" do
      # Friday 2024, January 31st
      travel_to Time.zone.local(2025, 1, 31)

      wednesday = create(:job, created_at: 2.day.ago)
      tuesday = create(:job, created_at: 3.day.ago)
      monday = create(:job, created_at: 4.day.ago)

      expect(grouped_records[:earlier_this_week].count).to eq(3)
      expect(grouped_records[:earlier_this_week]).to include(
        wednesday, tuesday, monday
      )
    end

    it "it does not includes records created today or yesterday" do
      # Friday 2024, January 31st
      travel_to Time.zone.local(2025, 1, 31)

      # Crreated on Friday
      create(:job, created_at: Date.today)
      # Created on Thursday
      create(:job, created_at: 1.day.ago)

      expect(grouped_records[:earlier_this_week]).to be_nil
    end

    it "it does not include records created last week" do
      # Friday 2024, January 31st
      travel_to Time.zone.local(2025, 1, 31)

      # Created on Monday last week
      create(:job, created_at: Date.today.last_week)
      expect(grouped_records[:earlier_this_week]).to be_nil
    end
  end

  it "groups records created last week" do
    # Friday 2024, January 31st
    travel_to Time.zone.local(2025, 1, 31)

    monday_week_after = create(:job, created_at: Date.today.at_beginning_of_week)

    # Last week
    start_of_week = Date.today.last_week.at_beginning_of_week

    sunday = create(:job, created_at: start_of_week + 6)
    saturday = create(:job, created_at: start_of_week + 5)
    friday = create(:job, created_at: start_of_week + 4)
    thursday = create(:job, created_at: start_of_week + 3)
    wednesday = create(:job, created_at: start_of_week + 2)
    tuesday = create(:job, created_at: start_of_week + 1)
    monday = create(:job, created_at: start_of_week)

    monday_week_before = create(:job, created_at: Date.today.weeks_ago(2).at_beginning_of_week)

    expect(grouped_records[:last_week].count).to eq(7)
    expect(grouped_records[:last_week]).to include(
      monday, tuesday, wednesday, thursday, friday, saturday, sunday
    )
    expect(grouped_records[:last_week]).not_to include(
      monday_week_after, monday_week_before
    )
  end

  it "groups records created two weeks ago" do
    # Friday 2024, January 31st
    travel_to Time.zone.local(2025, 1, 31)

    monday_week_after = create(:job, created_at: Date.today.last_week.beginning_of_week)

    # Two weeks ago
    start_of_week = Date.today.weeks_ago(2).at_beginning_of_week

    sunday = create(:job, created_at: start_of_week + 6)
    saturday = create(:job, created_at: start_of_week + 5)
    friday = create(:job, created_at: start_of_week + 4)
    thursday = create(:job, created_at: start_of_week + 3)
    wednesday = create(:job, created_at: start_of_week + 2)
    tuesday = create(:job, created_at: start_of_week + 1)
    monday = create(:job, created_at: start_of_week)

    monday_week_before = create(:job, created_at: Date.today.weeks_ago(3).at_beginning_of_week)

    expect(grouped_records[:two_weeks_ago].count).to eq(7)
    expect(grouped_records[:two_weeks_ago]).to include(
      monday, tuesday, wednesday, thursday, friday, saturday, sunday
    )
    expect(grouped_records[:two_weeks_ago]).not_to include(
      monday_week_after, monday_week_before
    )
  end

  it "groups records created three weeks ago" do
    # Friday 2024, January 31st
    travel_to Time.zone.local(2025, 1, 31)

    monday_week_after = create(:job, created_at: Date.today.weeks_ago(2).at_beginning_of_week)

    # Three weeks ago
    start_of_week = Date.today.weeks_ago(3).at_beginning_of_week

    sunday = create(:job, created_at: start_of_week + 6)
    saturday = create(:job, created_at: start_of_week + 5)
    friday = create(:job, created_at: start_of_week + 4)
    thursday = create(:job, created_at: start_of_week + 3)
    wednesday = create(:job, created_at: start_of_week + 2)
    tuesday = create(:job, created_at: start_of_week + 1)
    monday = create(:job, created_at: start_of_week)

    monday_week_before = create(:job, created_at: Date.today.weeks_ago(4).at_beginning_of_week)

    expect(grouped_records[:three_weeks_ago].count).to eq(7)
    expect(grouped_records[:three_weeks_ago]).to include(
      monday, tuesday, wednesday, thursday, friday, saturday, sunday
    )
    expect(grouped_records[:three_weeks_ago]).not_to include(
      monday_week_after, monday_week_before
    )
  end

  it "groups records created four weeks ago" do
    # Friday 2024, January 31st
    travel_to Time.zone.local(2025, 1, 31)

    monday_week_after = create(:job, created_at: Date.today.weeks_ago(3).at_beginning_of_week)

    # Four weeks ago
    start_of_week = Date.today.weeks_ago(4).at_beginning_of_week

    sunday = create(:job, created_at: start_of_week + 6)
    saturday = create(:job, created_at: start_of_week + 5)
    friday = create(:job, created_at: start_of_week + 4)
    thursday = create(:job, created_at: start_of_week + 3)
    wednesday = create(:job, created_at: start_of_week + 2)
    tuesday = create(:job, created_at: start_of_week + 1)
    monday = create(:job, created_at: start_of_week)

    monday_week_before = create(:job, created_at: Date.today.weeks_ago(5).at_beginning_of_week)

    expect(grouped_records[:four_weeks_ago].count).to eq(7)
    expect(grouped_records[:four_weeks_ago]).to include(
      monday, tuesday, wednesday, thursday, friday, saturday, sunday
    )
    expect(grouped_records[:four_weeks_ago]).not_to include(
      monday_week_after, monday_week_before
    )
  end

  it "groups records created last month" do
    # Friday 2024, January 31st
    travel_to Time.zone.local(2025, 1, 31)

    beginning_of_month_after = create(:job, created_at: Date.today.beginning_of_month)

    # Grouped into :four_weeks_ago
    last_day = create(:job, created_at: (Date.today << 1).end_of_month)

    # Grouped into :last_month
    first_day = create(:job, created_at: (Date.today << 1).beginning_of_month)

    last_day_month_before = create(:job, created_at: (Date.today << 2).end_of_month)

    expect(grouped_records[:last_month].count).to eq(1)
    expect(grouped_records[:last_month]).to include(
      first_day
    )
    expect(grouped_records[:last_month]).not_to include(
      beginning_of_month_after, last_day_month_before
    )
  end

  it "groups records created two months ago" do
    # Friday 2024, January 31st
    travel_to Time.zone.local(2025, 1, 31)

    beginning_of_month_after = create(:job, created_at: (Date.today << 1).beginning_of_month)

    # Grouped into :four_weeks_ago
    last_day = create(:job, created_at: (Date.today << 2).end_of_month)

    # Grouped into :last_month
    first_day = create(:job, created_at: (Date.today << 2).beginning_of_month)

    last_day_month_before = create(:job, created_at: (Date.today << 3).end_of_month)

    expect(grouped_records[:two_months_ago].count).to eq(2)
    expect(grouped_records[:two_months_ago]).to include(
      first_day, last_day
    )
    expect(grouped_records[:two_months_ago]).not_to include(
      beginning_of_month_after, last_day_month_before
    )
  end

  it "groups records created three months ago" do
    # Friday 2024, January 31st
    travel_to Time.zone.local(2025, 1, 31)

    beginning_of_month_after = create(:job, created_at: (Date.today << 2).beginning_of_month)

    # Grouped into :four_weeks_ago
    last_day = create(:job, created_at: (Date.today << 3).end_of_month)

    # Grouped into :last_month
    first_day = create(:job, created_at: (Date.today << 3).beginning_of_month)

    last_day_month_before = create(:job, created_at: (Date.today << 4).end_of_month)

    expect(grouped_records[:three_months_ago].count).to eq(2)
    expect(grouped_records[:three_months_ago]).to include(
      first_day, last_day
    )
    expect(grouped_records[:three_months_ago]).not_to include(
      beginning_of_month_after, last_day_month_before
    )
  end

  it "does not group records created more than three months ago" do
    # Friday 2024, January 31st
    travel_to Time.zone.local(2025, 1, 31)

    # First day, month after - September 30th, 2024
    create(:job, created_at: (Date.today << 4).end_of_month)

    expect(grouped_records).to be_empty
  end
end
