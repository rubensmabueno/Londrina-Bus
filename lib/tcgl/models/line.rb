module TCGL
  module Models
    class Line < TCGL::Models::Base
      attribute :code, type: :id
      attribute :title

      association :stops
    end
  end
end
