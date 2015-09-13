require 'rails_helper'

RSpec.describe TCGL::Parsers::Concerns::Base do
  subject { described_klass.new }

  let(:described_klass) { Class.new.include(described_class) }

  describe '#initialize' do
    subject { described_klass.new(raw_body) }

    let(:raw_body) { double }

    it 'calls on initialize_attributes and store the record' do
      expect(subject.raw_body).to eq raw_body
    end
  end

  describe '#body' do
    subject { described_klass.new(raw_body) }

    let(:raw_body) { double }

    it 'calls on JSON parse and catches the first' do
      expect(JSON).to receive(:parse).with(raw_body) { raw_body }
      expect(raw_body).to receive(:first)

      subject.body
    end
  end
end
