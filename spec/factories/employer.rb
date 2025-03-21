# frozen_string_literal: true

FactoryBot.define do
  factory :employer do
    name { Faker::Company.name }

    trait :with_logo do
      logo { Rack::Test::UploadedFile.new("app/assets/images/logos/default.jpg", "image/jpeg") }
    end
  end
end
