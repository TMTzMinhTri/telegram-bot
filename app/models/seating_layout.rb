class SeatingLayout
  class Seat
    include StoreModel::Model

    attribute :seat_number, type: :integer
    attribute :status, type: :boolean, default: false
    enum :genre, %i[regular occupied vip sweet_box aisle], default: :regular
  end
  include StoreModel::Model

  attribute :row, :string
  attribute :seats, Seat.to_array_type

  validates :row, presence: true, format: { with: /\A[a-zA-Z'-]*\z/ }
  validates :seats, store_model: true
end
