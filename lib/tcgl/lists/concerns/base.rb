module TCGL
  module Lists
    module Concerns
      module Base
        extend ActiveSupport::Concern

        included do
          include Enumerable

          attr_reader :options
        end

        class_methods do
          def model_name
            name.demodulize.singularize
          end

          def model_class
            @model_class ||= "TCGL::Models::#{model_name}".constantize
          end

          def request_class
            @request_class ||= "TCGL::Requests::#{model_name.pluralize}".constantize
          end
        end

        def initialize(options = {})
          @options = options
        end

        def collection
          @collection ||= raw_data.map { |member| self.class.model_class.new(member) }
        end

        def raw_data
          @raw_data ||= request_class_instance.fetch
        end

        def each
          collection.each { |member| yield member }
        end

        def request_class_instance
          @request_class_instance ||= self.class.request_class.new(options)
        end
      end
    end
  end
end
