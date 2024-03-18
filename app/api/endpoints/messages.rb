# frozen_string_literal: true

module Endpoints
  class Messages < Grape::API
    resource :messages do
      desc 'Create new messsage' do
      end
      params do
        requires :body, type: String, desc: 'Message body'
      end
      post do
        authenticate_user!
        MessageCreator.call(body: params[:body])
        {
          message: declared_params
        }
      end
    end
  end
end
