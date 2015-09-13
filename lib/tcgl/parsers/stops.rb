module TCGL
  module Parsers
    class Stops
      include Concerns::Base

      def to_hash
        array = []
        code.each_with_index { |_, index| array << { code: code[index], title: title[index] } }
        array
      end

      def code
        @code ||= body['cod']
      end

      def title
        @title ||= body['valor'].map { |value| value.to_s.split(' - ').last.to_sym }
      end
    end
  end
end
