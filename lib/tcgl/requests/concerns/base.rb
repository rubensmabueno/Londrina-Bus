module TCGL
  module Requests
    module Concerns
      module Base
        extend ActiveSupport::Concern

        included do
          attr_reader :options
        end

        class_methods do
          def model_name
            name.demodulize.singularize
          end

          def parser_class
            @parser_class ||= "TCGL::Parsers::#{model_name.pluralize}".constantize
          end
        end

        def initialize(options = {})
          @options = options
        end

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
      end
    end
  end
end
