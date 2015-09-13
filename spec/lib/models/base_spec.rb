require 'rails_helper'

RSpec.describe TCGL::Models::Base do
  describe '.all' do
    let(:list_class) { double }

    before { allow(described_class).to receive(:list_class) { list_class } }

    it 'instantiate a list class' do
      expect(list_class).to receive(:new)
      described_class.all
    end
  end

  describe '.attribute' do
    let(:attr_name) { :foo }

    it 'defines an attr_accessor for the class and stores the attr_name on the attributes accessor' do
      expect(described_class).to receive(:attr_accessor).with(:foo)
      described_class.attribute(attr_name)
      expect(described_class.attributes).to include(:foo)
    end

    after { described_class.attributes.delete(attr_name) }
  end

  describe '#initialize' do
    subject { described_class.new(record) }

    let(:record) { double }

    before { allow_any_instance_of(described_class).to receive(:initialize_attributes) }

    it 'calls on initialize_attributes and store the record' do
      expect(subject.record).to eq record
      expect(subject).to have_received(:initialize_attributes)
    end
  end

  describe '#initialize_attributes' do
    subject { described_class.new(record) }

    let(:record) { double }
    let(:attributes) { [:foo, :bar] }

    before do
      allow(described_class).to receive(:attributes) { attributes }
      allow_any_instance_of(described_class).to receive(:initialize_attributes)

      allow(record).to receive(:[]).with(:foo) { 'foo' }
      allow(record).to receive(:[]).with(:bar) { 'bar' }
    end

    it 'calls on setter for each attribute' do
      expect(subject).to receive(:public_send).with('foo=', 'foo')
      expect(subject).to receive(:public_send).with('bar=', 'bar')
      allow_any_instance_of(described_class).to receive(:initialize_attributes).and_call_original

      subject.initialize_attributes
    end
  end
end