# frozen_string_literal: true

module TelegramBot
  class RenameController < BaseController
    def rename!(*)
      # set context for the next message
      save_context :rename_from_message
      respond_with :message, text: 'What name do you like?'
    end

    def rename_from_message(*words)
      Rails.logger.debug '----'
      Rails.logger.debug words
      Rails.logger.debug '----'
      respond_with :message, text: 'Renamed!'
    end
  end
end
