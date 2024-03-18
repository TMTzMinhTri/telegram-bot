# frozen_string_literal: true

module Entities
  class Client < Grape::Entity
    expose :id
    expose :name, documentation: {
      type: :string,
      desc: 'Client name',
      required: true
    }
    expose :phone_number, documentation: {
      type: :string,
      desc: 'Client phone number',
      required: true
    }
    expose :email
    expose :telegram_chat_id
    expose :telegram_sign_in_at
    expose :locked_at
    expose :user, using: Entities::User
  end
end
