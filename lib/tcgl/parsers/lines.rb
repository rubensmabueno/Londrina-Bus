module TCGL
  module Parsers
    class Lines < Base
      def to_hash
        array = Array.new
        code.each_with_index { |item, index| array << { code: code[index], title: title[index] } }
        array
      end

      def code
        @code ||= body['cod']
      end

      def title
        @title ||= body['valor']
      end
    end
  end
end