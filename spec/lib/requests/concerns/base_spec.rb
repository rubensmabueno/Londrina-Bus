require 'rails_helper'

RSpec.describe TCGL::Requests::Concerns::Base do
  subject { described_klass.new }

  let(:described_klass) { Class.new.include(described_class) }

  describe '.model_name' do
    before { allow(described_klass).to receive(:name) { 'Foo::Bar' } }

    it { expect(described_klass.model_name).to eq 'Bar' }
  end

  describe '#initialize' do
    subject { described_klass.new(options) }

    let(:options) { double }

    it 'stores the options' do
      expect(subject.options).to eq options
    end
  end

  describe '#connection' do
    it 'instantiate a Faraday request class' do
      expect(Faraday).to receive(:new).with(url: 'http://site.tcgrandelondrina.com.br:8082')
      subject.connection
    end
  end

  describe '#fetch' do
    let(:parser_class) { double }
    let(:body) { double }

    before { allow(subject).to receive(:body) { body } }

    it 'instantiate a parser_class passing the body and calling to_hash' do
      expect(described_klass).to receive(:parser_class) { parser_class }
      expect(parser_class).to receive(:new).with(body) { parser_class }
      expect(parser_class).to receive(:to_hash)

      subject.fetch
    end
  end

  describe '#body' do
    let(:request) { double }

    before { allow(subject).to receive(:request) { request } }

    it 'calls on body of the request' do
      expect(request).to receive(:body)
      subject.body
    end
  end

  describe '#request' do
    let(:connection) { double }

    before { allow(subject).to receive(:connection) { connection } }

    it 'calls on get of the connection' do
      expect(connection).to receive(:get).with('/')
      subject.request
    end
  end
end
