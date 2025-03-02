require "rails_helper"

RSpec.describe "User signs up & signs in" do
  it "redirects users to their account page after they sign up or sign in" do
    visit sign_up_path

    expect(page).to have_content("Sign up")

    fill_in "Email", with: "example@email.com"
    fill_in "Password", with: "Password123@"
    fill_in "Password confirmation", with: "Password123@"

    click_button "Sign up"

    expect(page).to have_current_path(account_path)

    click_button "Sign out"

    expect(page).to have_content("Sign in to your account")

    fill_in "Email", with: "example@email.com"
    fill_in "Password", with: "Password123@"

    click_button "Sign in"

    expect(page).to have_current_path(account_path)
  end
end
