# frozen_string_literal: true

# Ceates or updates a job record
class SaveJob
  def self.call(employer:, attributes:)
    job = Job.find_or_create_by(url: attributes.url)

    # Update with latest attributes
    job.update(
      board: attributes.board,
      url: attributes.url,
      title: attributes.title,
      location: attributes.location,
      html_content: attributes.html_content,
      employer:
    )
  end
end
