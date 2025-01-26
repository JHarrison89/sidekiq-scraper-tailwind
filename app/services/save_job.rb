# frozen_string_literal: true

# Ceates or updates a job record
class SaveJob
  def self.call(attributes)
    job = Job.find_or_create_by(url: attributes.url)

    # Update with latest attributes
    job.update(
      company_name: attributes.company_name,
      url: attributes.url,
      title: attributes.title,
      employer: attributes.employer,
      location: attributes.location,
      html_content: attributes.html_content
    )
  end
end
