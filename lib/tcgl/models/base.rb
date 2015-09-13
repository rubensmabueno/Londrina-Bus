module TCGL
  module Models
    class Base
      attr_accessor :id
      attr_reader :record
      cattr_accessor :attributes

      def self.all
        list_class.new
      end

      def self.where(options)
        list_class.new(options)
      end

      def self.attribute(attr_name, options = {})
        self.attributes ||= []
        self.attributes << { attr_name: attr_name, options: options }

        attr_accessor attr_name
      end

      def self.association(assoc_name)
        define_method(assoc_name) do |options = {}|
          "TCGL::Models::#{assoc_name.to_s.singularize.capitalize}".constantize.where(options.merge(key_name => id))
        end
      end

      def initialize(record)
        @record ||= record

        initialize_attributes
      end

      def initialize_attributes
        self.class.attributes.each do |attribute|
          public_send("#{attribute[:attr_name]}=", record[attribute[:attr_name]])
          self.id = record[attribute[:attr_name]] if attribute[:options][:type] == :id
        end
      end

      private

      def key_name
        @key_name ||= "#{self.class.model_name.underscore}_id".to_sym
      end

      def self.model_name
        @model_name ||= self.name.demodulize
      end

      def self.list_class
        @list_class ||= "TCGL::Lists::#{model_name.pluralize}".constantize
      end
    end
  end
end