module TCGL
  module Requests
    class Base
      def connection
        Faraday.new(url: 'http://site.tcgrandelondrina.com.br:8082') do |faraday|
          faraday.response :logger
          faraday.adapter Faraday.default_adapter
        end
      end

      def fetch
        self.class.parser_class.new(body).to_hash
      end

      def body
        request.body
      end

      def request
        connection.get('/')
      end

      private

      def self.model_name
        self.name.demodulize.singularize
      end

      def self.parser_class
        @parser_class ||= "TCGL::Parsers::#{model_name.pluralize}".constantize
      end
    end
  end
end