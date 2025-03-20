# frozen_string_literal: true

FactoryBot.define do
  factory :job_show do
    board { Faker::Company.name }
    url { Faker::Internet.url }
    script { "ShowPageScript" }
  end
end
