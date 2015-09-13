module TCGL
  module Lists
    class Base
      include Enumerable

      def collection
        @collection ||= raw_data.map { |member| self.class.model_class.new(member) }
      end

      def raw_data
        @raw_data ||= self.class.request_class.new.fetch
      end

      def each
        collection.each { |member| yield member }
      end

      private

      def self.model_name
        self.name.demodulize.singularize
      end

      def self.model_class
        @model_class ||= "TCGL::Models::#{model_name}".constantize
      end

      def self.request_class
        @request_class ||= "TCGL::Requests::#{model_name.pluralize}".constantize
      end
    end
  end
end