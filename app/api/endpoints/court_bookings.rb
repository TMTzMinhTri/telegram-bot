module Endpoints
  class CourtBookings < Grape::API
    resource :court_bookings do
      params do
        optional :filter_by, type: Hash do
          requires :start_date, type: Date
          requires :end_date, type: Date
        end
      end
      get do
        court_bookings = if declared_params[:filter_by].present?
                           CourtBooking.filter_by_date(declared_params[:filter_by])
                         else
                           CourtBooking.this_month
                         end

        court_bookings
      end

      params do
        requires :court_fee, type: Integer
        requires :start_at, type: Time
        requires :end_at, type: Time
      end
    end
  end
end
