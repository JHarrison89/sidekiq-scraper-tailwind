# frozen_string_literal: true

FactoryBot.define do
  factory :JobShow do
    company { Faker::Company.name }
    url { Faker::Internet.url }
    script { 'JobShowPageScript' }
  end
end
