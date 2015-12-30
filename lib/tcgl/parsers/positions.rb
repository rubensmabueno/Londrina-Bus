module TCGL
  module Parsers
    class Positions
      include Concerns::Base

      def to_hash
        coordinates_array.map do |coordinates|
          {
              type: coordinates[0].strip,
              destination: coordinates[1].strip,
              extra: coordinates[2].strip,
              lat: coordinates[3].to_f,
              lng: coordinates[4].to_f,
              on: coordinates[5].to_f
          }
        end
      end

      def coordinates_array
        raw_coordinates.split('&').in_groups_of(6)[0...-1]
      end

      def raw_coordinates
        @raw_coordinates ||= JSON.parse(raw_body)['cordenadas']
      end
    end
  end
end
