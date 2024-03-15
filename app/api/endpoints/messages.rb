module Endpoints
  class Messages < Grape::API
    resource :messages do
      desc 'Create new messsage' do
      end
      params do
        requires :body, type: String, desc: 'Message body'
      end
      post do
        result = MessageCreator.call(body: params[:body])
        {
          message: result || 'true'
        }
      end
    end
  end
end
