module TCGL
  module Models
    class Line
      include Concerns::Base

      attribute :code, type: :id
      attribute :title

      association :stops
      association :schedules
    end
  end
end
