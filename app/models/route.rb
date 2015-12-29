class Route < ActiveRecord::Base
  belongs_to :line

  belongs_to :origin, class_name: Stop.name
  belongs_to :destination, class_name: Stop.name

  scope :on, -> (day) { where(day: day) }
end
