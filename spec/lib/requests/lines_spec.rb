require 'rails_helper'

RSpec.describe TCGL::Requests::Lines do
  describe '#request' do
    let(:connection) { double }
    let(:request) { double }
    let(:headers) { double }
    let(:params) { double }

    before do
      allow(subject).to receive(:connection) { connection }
      allow(request).to receive(:headers) { headers }
      allow(request).to receive(:params) { params }
    end

    it 'passes headers and params' do
      expect(connection).to receive(:post).with('/Soap/BuscarLinhas').and_yield(request)
      expect(headers).to receive(:[]=).with('Accept', 'application/json, text/javascript, */*; q=0.01')
      expect(headers).to receive(:[]=).with('Content-Type', 'application/x-www-form-urlencoded; charset=UTF-8')
      expect(params).to receive(:[]=).with('buscarlinha', 'Linhas Convencionais')
      expect(params).to receive(:[]=).with('rnd', '0.67223068652674560')

      subject.request
    end
  end
end