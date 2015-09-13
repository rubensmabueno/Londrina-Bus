module TCGL
  module Parsers
    class Schedules
      include Concerns::Base

      def to_hash
        array = []
        departures.each_with_index do |_, index|
          array << { departure: departures[index], arrival: arrivals[index], path: paths[index]  }
        end
        array
      end

      def departures
        @departures ||= schedule_tables.map do |schedule_table|
          schedule_table.css('tr:not(.TextoTitulo)').map { |tr| tr.css('td:nth-of-type(1)').text }
        end.flatten
      end

      def arrivals
        @arrivals ||= schedule_tables.map do |schedule_table|
          schedule_table.css('tr:not(.TextoTitulo)').map { |tr| tr.css('td:nth-of-type(3)').text }
        end.flatten
      end

      def paths
        @paths ||= schedule_tables.map do |schedule_table|
          schedule_table.css('tr:not(.TextoTitulo)').map { |tr| tr.css('td:nth-of-type(5)').text }
        end.flatten
      end

      def schedule_tables
        @schedule_tables ||= nokogiri_html.css('.tabHoraria')
      end

      def nokogiri_html
        @nokogiri_html ||= Nokogiri::HTML(raw_body)
      end
    end
  end
end
