module TCGL
  module Parsers
    module Concerns
      module Base
        extend ActiveSupport::Concern

        included do
          attr_reader :raw_body
        end

        def initialize(raw_body)
          @raw_body = raw_body
        end

        def body
          @body ||= JSON.parse(raw_body).first
        end
      end
    end
  end
end
