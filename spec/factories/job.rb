# frozen_string_literal: true

FactoryBot.define do
  factory :job do
    url { "bigcompany.com/job" }
    title { "Head of ticketing" }
    location { "London" }
    html_content { "<p>Job description</p>" }

    association :employer, :with_logo
    association :board, :with_logo
  end
end
