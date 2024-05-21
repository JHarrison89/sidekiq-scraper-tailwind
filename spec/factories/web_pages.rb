# frozen_string_literal: true

FactoryBot.define do
  factory :WebPage do
    company { Faker::Company.name }
    url { Faker::Internet.url }
    script { '/script.rb' }
  end
end
