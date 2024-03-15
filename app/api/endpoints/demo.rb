# frozen_string_literal: true

module Endpoints
  class Demo < Grape::API
    resource :demo do
      get do
        logger.debug env.keys
        true
      end
    end
  end
end
