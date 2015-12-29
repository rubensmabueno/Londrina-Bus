class Stop < ActiveRecord::Base
  has_many :routes_from, foreign_key: :origin_id, class_name: Route.name
  has_many :routes_to, foreign_key: :destination_id, class_name: Route.name
end
