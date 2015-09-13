module TCGL
  module Models
    class Stop
      include Concerns::Base

      attribute :code, type: :id
      attribute :title
    end
  end
end
