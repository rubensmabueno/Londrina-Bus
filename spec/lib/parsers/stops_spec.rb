require 'rails_helper'

RSpec.describe TCGL::Parsers::Stops do
  describe '#to_hash' do
    subject { described_class.new(double) }

    let(:code) { [1, 2, 3] }
    let(:title) { [:foo, :bar, :zig] }

    before do
      allow(subject).to receive(:code) { code }
      allow(subject).to receive(:title) { title }
    end

    it 'returns an array of hashes containing code and title' do
      expect(subject.to_hash).to eq(
        [
          { code: 1, title: :foo },
          { code: 2, title: :bar },
          { code: 3, title: :zig }
        ]
      )
    end
  end

  describe '#code' do
    subject { described_class.new(double) }
    let(:body) { { 'cod' => [:foo] } }

    before { allow(subject).to receive(:body) { body } }

    it { expect(subject.code).to eq [:foo] }
  end

  describe '#title' do
    subject { described_class.new(double) }
    let(:body) { { 'valor' => [:foo] } }

    before { allow(subject).to receive(:body) { body } }

    it { expect(subject.title).to eq [:foo] }

    context 'when title has dashes' do
      let(:body) { { 'valor' => [:'foo - bla'] } }

      it { expect(subject.title).to eq [:bla] }
    end
  end
end
