module Entities
  class Theater < Grape::Entity
    expose :id
    expose :name
    expose :seats_count
    expose :seats_count_available
    expose :cinama_id
    expose :seating_layouts, using: Entities::SeatingLayout
  end
end
