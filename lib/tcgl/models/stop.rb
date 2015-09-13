module TCGL
  module Models
    class Stop < TCGL::Models::Base
      attribute :code, type: :id
      attribute :title
    end
  end
end
