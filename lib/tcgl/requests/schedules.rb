module TCGL
  module Requests
    class Schedules
      include Concerns::Base

      def request
        fail ArgumentError if line_id.blank? || day_id.blank? || origin_stop_id.blank? || destination_stop_id.blank?

        connection.post('/Soap/BuscaHorarios') do |req|
          req.headers['Content-Type'] = 'application/x-www-form-urlencoded; charset=UTF-8'
          req.params['idLinha'] = line_id
          req.params['idDia'] = day_id
          req.params['idLinhaO'] = origin_stop_id
          req.params['idLinhaD'] = destination_stop_id
        end
      end

      def line_id
        @line_id ||= options[:line_id].to_i
      end

      def day_id
        @day_id ||= options[:day_id]
      end

      def origin_stop_id
        @origin_stop_id ||= options[:origin_stop_id]
      end

      def destination_stop_id
        @destination_stop_id ||= options[:destination_stop_id]
      end
    end
  end
end
