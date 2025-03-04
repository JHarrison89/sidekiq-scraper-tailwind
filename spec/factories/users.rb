# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    email { "example@email.com" }
    password { "Password123@" }
  end
end
