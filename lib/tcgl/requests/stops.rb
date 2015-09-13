module TCGL
  module Requests
    class Stops < Base
      def request
        fail ArgumentError, 'Missing arguments for fetching' if line_id.blank? || day_id.blank?

        connection.post('/Soap/BuscarPontos') do |req|
          req.headers['Accept'] = 'application/json, text/javascript, */*; q=0.01'
          req.headers['Content-Type'] = 'application/x-www-form-urlencoded; charset=UTF-8'
          req.params['pLinha'] = line_id
          req.params['pDia'] = day_id
        end
      end

      def line_id
        @line_id ||= options[:line_id]
      end

      def day_id
        @day_id ||= options[:day_id]
      end
    end
  end
end
