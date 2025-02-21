# frozen_string_literal: true

module Endpoints
  class Demo < Grape::API
    resource :demo do
      get do
        start_time = Time.now.to_f
        host_name = Socket.gethostname
        end_time = Time.now.to_f

        {
          start_time:,
          host_name:,
          end_time:
        }
      end

      params do
        requires :court_fee, type: Float
        requires :start_at, type: DateTime
        requires :end_at, type: DateTime
        requires :court_booking_players_attributes, type: [JSON] do
          optional :player_id, type: String
          requires :hours_played, type: Integer
          optional :invited_by, type: Integer
          optional :name, type: String
        end
      end
      post do
        new_params = declared_params.merge({ duration: params[:start_at].utc..params[:end_at].utc })
        new_params.delete(:start_at)
        new_params.delete(:end_at)
        p new_params
        court_booking = CourtBooking.new(new_params)
        court_booking.save!
        court_booking
      end
    end
  end
end
