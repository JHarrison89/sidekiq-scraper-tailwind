# frozen_string_literal: true

class ExampleMailer < ApplicationMailer
  def hello_world(contact)
    @contact = contact
    mail(to: @contact, subject: "This is an example mail")
    # The subject will be the subject of the email being sent
  end
end
