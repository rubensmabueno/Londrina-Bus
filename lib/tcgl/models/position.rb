module TCGL
  module Models
    class Position
      include Concerns::Base

      attribute :type
      attribute :destination
      attribute :extra
      attribute :lat
      attribute :lng
      attribute :on
    end
  end
end
