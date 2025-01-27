Bugsnag.configure do |config|
  config.api_key = Rails.application.credentials.BUGSNAG_API_KEY
end
