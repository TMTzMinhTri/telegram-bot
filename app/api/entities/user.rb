module Entities
  class User < Grape::Entity
    expose :id
    expose :email
    expose :name
    expose :phone_number
  end
end
