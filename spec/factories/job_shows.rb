# frozen_string_literal: true

FactoryBot.define do
  factory :JobShow do
    company { Faker::Company.name }
    url { Faker::Internet.url }
    script { 'ShowPageScript' }
  end
end
