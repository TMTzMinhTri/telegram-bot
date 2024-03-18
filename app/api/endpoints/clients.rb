# frozen_string_literal: true

module Endpoints
  class Clients < RootApi # rubocop:disable Style/Documentation
    helpers GlobalHelpers

    resource :clients do # rubocop:disable Metrics/BlockLength
      desc 'Create new clients' do
        success Entities::Client
      end
      params do
        requires :name, type: String, desc: 'Client name'
        requires :password, type: String, desc: 'Client password'
        requires :phone_number, type: String, desc: 'Client phone number'
        optional :email, type: String, desc: 'Client email'
      end
      post do
        authenticate_user!
        client = current_user.clients.create!(declared_params)
        present client, with: Entities::Client
      end

      desc 'Create new clients' do
        success Entities::Client
      end
      get do
        authenticate_user!
        clients = current_user.clients
        present clients, with: Entities::Client
      end

      route_param :id, type: Integer do
        desc 'Update client' do
          success Entities::Client
        end
        params do
          requires :name, type: String, desc: 'Client name'
        end
        put do
          authenticate_user!
          client = current_user.clients.find(params[:id])
          client.update!(declared_params)
          present client, with: Entities::Client
        end
      end
    end
  end
end
