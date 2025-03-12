FactoryBot.define do
  factory :board do
    name { Faker::Company.name }

    trait :with_logo do
      logo { Rack::Test::UploadedFile.new("app/assets/images/logos/default.jpg", "image/jpeg") }
    end
  end
end
