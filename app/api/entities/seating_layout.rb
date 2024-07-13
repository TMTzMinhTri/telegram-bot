module Entities
  class Seats < Grape::Entity
    expose :status
    expose :seat_number
    expose :genre
  end

  class SeatingLayout < Grape::Entity
    expose :row
    expose :seats, using: Seats
  end
end
