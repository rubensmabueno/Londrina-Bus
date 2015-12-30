module TCGL
  module Parsers
    class Itineraries
      include Concerns::Base

      def to_hash
        transform(ida_array) + transform(volta_array)
      end

      def transform(itinerary_array)
        itinerary_array.each_with_object([]) do |e, array|
          array << {
              name: e['Nome'],
              to: e['Sentido'],
              lat: e['Lat'].to_f,
              lng: e['Lng'].to_f,
              order: array.size
          }
        end
      end

      def ida_array
        @ida_array ||= JSON.parse(raw_body)['ida']
      end

      def volta_array
        @volta_array ||= JSON.parse(raw_body)['volta']
      end
    end
  end
end
