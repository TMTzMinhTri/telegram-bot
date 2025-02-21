module Telegram
  class SessionController < ApplicationController
    def index; end

    def create
      # user = User.first
      token = Devise.friendly_token(10)
      payload = Base64.urlsafe_encode64(token)
      telegram_redirect_url = "tg://resolve?domain=bingo_bet_lottery_bot&start=#{payload}"
      redirect_to telegram_redirect_url, allow_other_host: true
    end
  end
end
