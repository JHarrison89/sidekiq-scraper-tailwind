module AuthHelpers
  # Follows controller redirect to /account
  def sign_in_as(user)
    post sign_in_url, params: {
      email: user.email,
      password: user.password
    }
    follow_redirect! if response.redirect?
  end

  # Sets the session cookie user in the controller, but does not follow the redirect
  # This is a better option when we want to keep our tests isolated.
  # Example: using sign_in_as(), any errors in the /account view will be returned in the tests
  # and can cause confusion. Using session_user_is() avoids this issue by not following the redirect.
  def session_user_is(user)
    post sign_in_url, params: {
      email: user.email,
      password: user.password
    }
  end
end
