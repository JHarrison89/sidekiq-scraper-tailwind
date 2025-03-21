FactoryBot.define do
  factory :job_user do
    status { "saved" }

    association :job, :with_logo
    association :user
  end
end
