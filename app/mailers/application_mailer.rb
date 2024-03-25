# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: 'from@example.com'
  layout 'mailer'

  protected

  def header_for(subject:, to:)
    {
      subject:,
      to:
    }
  end
end
