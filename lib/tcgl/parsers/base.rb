module TCGL
  module Parsers
    class Base
      attr_reader :raw_body

      def initialize(raw_body)
        @raw_body = raw_body
      end

      def body
        @body ||= JSON.parse(raw_body).first
      end
    end
  end
end