module DateSortable
  extend ActiveSupport::Concern

  def organize_by_date(jobs)
    result = jobs.all.group_by { _1.created_at.to_date }
    result.sort_by { |key, _| key }.reverse
  end
end
