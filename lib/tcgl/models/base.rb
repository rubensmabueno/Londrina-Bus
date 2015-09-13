module TCGL
  module Models
    class Base
      attr_reader :record
      cattr_accessor :attributes

      def self.all
        list_class.new
      end

      def self.attribute(attr_name)
        self.attributes ||= []
        self.attributes << attr_name

        attr_accessor attr_name
      end

      def initialize(record)
        @record ||= record

        initialize_attributes
      end

      def initialize_attributes
        self.class.attributes.each do |attribute|
          public_send("#{attribute}=", record[attribute])
        end
      end

      private

      def self.model_name
        self.name.demodulize
      end

      def self.list_class
        @list_class ||= "TCGL::Lists::#{model_name.pluralize}".constantize
      end
    end
  end
end