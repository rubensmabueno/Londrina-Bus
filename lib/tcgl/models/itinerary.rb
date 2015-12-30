module TCGL
  module Models
    class Itinerary
      include Concerns::Base

      attribute :name
      attribute :to
      attribute :lat
      attribute :lng
      attribute :order
      attribute :type
    end
  end
end
