# frozen_string_literal: true

require "rails_helper"

# In this test, we're checking the response status of our methods.
# In the sign_in_as method, we're following the redirect and get a 200 status.
# In the session_user_is method, we're not following the redirect and get a 302 status.
#
# The real aim of these tests are to check we are/or are not redirecting after signing in.
#
# TODO: consider converting this file into a feature spec.

RSpec.describe "AuthHelper", type: :request do
  describe "#sign_in_as" do
    it "signs in the user and follows the redirect" do
      user = create(:user)
      sign_in_as(user)

      expect(response.status).to eq(200)
    end
  end

  describe "#session_user_is" do
    it "signs in the user and follows the redirect" do
      user = create(:user)
      session_user_is(user)

      expect(response.status).to eq(302)
    end
  end
end
