# frozen_string_literal: true

class ApplicationController < ActionController::Base
  def default_url_options
    { host: 'localhost:3000' }
  end
end
