# frozen_string_literal: true

module TelegramAuthenticatable
  extend ActiveSupport::Concern

  def login(phone_number, password)
    client = Client.find_for_database_authentication(phone_number:)
    if client&.valid_password?(password)
      client.update_telegram_session(chat['id'])
      session['client_id'] = client.id
      respond_with :message, text: t('.already_authenticated')
    else
      save_context(:login)
      respond_with :message, text: t('.invalid')
    end
  end
end
