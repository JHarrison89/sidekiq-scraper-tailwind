# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: "Jeremaia <myrailsmail@gmail.com>"
  layout "mailer"
end
