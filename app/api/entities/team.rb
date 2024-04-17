module Entities
  class Team < Grape::Entity
    expose :id
    expose :name
    expose :owner
  end
end
