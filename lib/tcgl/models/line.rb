module TCGL
  module Models
    class Line
      include Concerns::Base

      attribute :code, type: :id
      attribute :title

      association :stops
      association :schedules
      association :itineraries
      association :positions
    end
  end
end
