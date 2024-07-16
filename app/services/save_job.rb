# frozen_string_literal: true

# Ceates or updates a job record
class SaveJob
  def self.call(attributes)
    job = Job.find_or_create_by(url: attributes.url)

    # Update with latest attributes
    job.update(
      company_name: attributes.company_name,
      title: attributes.title,
      url: attributes.url
    )
  end
end
