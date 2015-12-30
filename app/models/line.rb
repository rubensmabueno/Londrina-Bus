class Line < ActiveRecord::Base
  has_many :routes, dependent: :destroy
  has_many :schedules, through: :routes, dependent: :destroy
  has_many :origins, through: :routes, dependent: :destroy
  has_many :destinations, through: :routes, dependent: :destroy

  def positions
    TCGL::Models::Position.where(line_id: code)
  end
end
