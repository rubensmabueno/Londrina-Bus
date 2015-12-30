module TCGL
  module Requests
    class Itineraries
      include Concerns::Base

      def request
        fail ArgumentError if line_id.blank?

        connection.post('/Soap/BuscaItinerarios') do |req|
          req.headers['Accept'] = 'application/json, text/javascript, */*; q=0.01'
          req.headers['Content-Type'] = 'application/x-www-form-urlencoded; charset=UTF-8'
          req.params['linha'] = line_id
        end
      end

      def line_id
        @line_id ||= options[:line_id]
      end
    end
  end
end
