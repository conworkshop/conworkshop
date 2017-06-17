# frozen_string_literal: true
class ApplicationMailer < ActionMailer::Base
  default from: 'CWS Automailer <noreply@conworkshop.com>'
  layout 'mailer'
end
