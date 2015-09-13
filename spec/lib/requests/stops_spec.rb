require 'rails_helper'

RSpec.describe TCGL::Requests::Stops do
  describe '#request' do
    subject { described_class.new(options) }

    let(:connection) { double }
    let(:request) { double }
    let(:headers) { double }
    let(:params) { double }
    let(:options) { { line_id: 'foo', day_id: 'bar' } }

    before do
      allow(subject).to receive(:connection) { connection }
      allow(request).to receive(:headers) { headers }
      allow(request).to receive(:params) { params }
    end

    it 'passes headers and params' do
      expect(connection).to receive(:post).with('/Soap/BuscarPontos').and_yield(request)
      expect(headers).to receive(:[]=).with('Accept', 'application/json, text/javascript, */*; q=0.01')
      expect(headers).to receive(:[]=).with('Content-Type', 'application/x-www-form-urlencoded; charset=UTF-8')
      expect(params).to receive(:[]=).with('pLinha', 'foo')
      expect(params).to receive(:[]=).with('pDia', 'bar')

      subject.request
    end
  end
end
