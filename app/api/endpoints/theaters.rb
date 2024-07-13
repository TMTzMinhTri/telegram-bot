module Endpoints
  class Theaters < RootApi
    resources :theaters do
      params do
        requires :name, type: String
        requires :seating_layouts, type: Array do
          requires :row, type: String
          requires :seats, type: Array do
            requires :seat_number, type: Integer
            requires :genre, type: Symbol, values: %i[regular occupied vip sweet_box aisle], default: :regular
            requires :status, type: Boolean
          end
        end
      end
      post do
        theater = Theater.new(declared_params)
        theater.cinama_id = Cinama.current.id
        theater.save!
        present theater, with: Entities::Theater
      end

      get do
        theaters = Theater.all
        present theaters, with: Entities::Theater
      end
    end
  end
end
