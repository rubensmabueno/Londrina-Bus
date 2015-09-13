module TCGL
  module Models
    class Schedule
      include Concerns::Base

      attribute :departure
      attribute :arrival
      attribute :path
    end
  end
end
