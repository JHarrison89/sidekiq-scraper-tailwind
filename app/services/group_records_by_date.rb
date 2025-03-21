# frozen_string_literal: true

# Used to group records by creation date, e.g. job records.
# I've made an intentional decision to create this as a service object
# instead of a controller concern. It matches the criteria for both but
# it's easier to test as a service object and fits the pattern of this
# app of leaning into service objects for business logic.
class GroupRecordsByDate
  def self.call(records)
    grouped = {
      today: [],
      yesterday: [],
      earlier_this_week: [],
      last_week: [],
      two_weeks_ago: [],
      three_weeks_ago: [],
      four_weeks_ago: [],
      last_month: [],
      two_months_ago: [],
      three_months_ago: []
    }

    records.each do |record|
      created_at = record.created_at.to_date
      today = Date.today
      start_of_week = today.beginning_of_week
      last_week_start = start_of_week - 7
      last_week_end = start_of_week - 1
      two_weeks_ago_start = start_of_week - 14
      two_weeks_ago_end = start_of_week - 8
      three_weeks_ago_start = start_of_week - 21
      three_weeks_ago_end = start_of_week - 15
      four_weeks_ago_start = start_of_week - 28
      four_weeks_ago_end = start_of_week - 22

      case created_at
      when today
        grouped[:today] << record
      when today - 1
        grouped[:yesterday] << record
      when (start_of_week < today - 1) && (start_of_week..today - 1)
        grouped[:earlier_this_week] << record
      when last_week_start..last_week_end
        grouped[:last_week] << record
      when two_weeks_ago_start..two_weeks_ago_end
        grouped[:two_weeks_ago] << record
      when three_weeks_ago_start..three_weeks_ago_end
        grouped[:three_weeks_ago] << record
      when four_weeks_ago_start..four_weeks_ago_end
        grouped[:four_weeks_ago] << record
      when (today << 1).beginning_of_month..(today << 1).end_of_month
        grouped[:last_month] << record
      when (today << 2).beginning_of_month..(today << 2).end_of_month
        grouped[:two_months_ago] << record
      when (today << 3).beginning_of_month..(today << 3).end_of_month
        grouped[:three_months_ago] << record
      end
    end

    grouped.reject { |_, records| records.empty? }
  end
end
