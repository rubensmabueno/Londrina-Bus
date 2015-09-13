require 'rails_helper'

RSpec.describe TCGL::Requests::Schedules do
  describe '#request' do
    subject { described_class.new(options) }

    let(:connection) { double }
    let(:request) { double }
    let(:headers) { double }
    let(:params) { double }
    let(:options) { { line_id: 1, day_id: 2, origin_stop_id: 3, destination_stop_id: 4 } }

    before do
      allow(subject).to receive(:connection) { connection }
      allow(request).to receive(:headers) { headers }
      allow(request).to receive(:params) { params }
    end

    it 'passes headers and params' do
      expect(connection).to receive(:post).with('/Soap/BuscaHorarios').and_yield(request)
      expect(headers).to receive(:[]=).with('Content-Type', 'application/x-www-form-urlencoded; charset=UTF-8')
      expect(params).to receive(:[]=).with('idLinha', 1)
      expect(params).to receive(:[]=).with('idDia', 2)
      expect(params).to receive(:[]=).with('idLinhaO', 3)
      expect(params).to receive(:[]=).with('idLinhaD', 4)

      subject.request
    end
  end
end
