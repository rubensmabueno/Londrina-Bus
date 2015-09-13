module TCGL
  module Requests
    class Lines < Base
      def request
        connection.post('/Soap/BuscarLinhas') do |req|
          req.headers['Accept'] = 'application/json, text/javascript, */*; q=0.01'
          req.headers['Content-Type'] = 'application/x-www-form-urlencoded; charset=UTF-8'
          req.params['buscarlinha'] = 'Linhas Convencionais'
          req.params['rnd'] = '0.67223068652674560'
        end
      end
    end
  end
end