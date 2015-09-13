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

  describe '.where' do
    let(:options) { double }
    let(:list_class) { double }

    before { allow(described_class).to receive(:list_class) { list_class } }

    it 'instantiate a list class' do
      expect(list_class).to receive(:new).with(options)
      described_class.where(options)
    end
  end

  describe '.attribute' do
    let(:attr_name) { :foo }
    let(:options) { double }

    it 'defines an attr_accessor for the class and stores the attr_name on the attributes accessor' do
      expect(described_class).to receive(:attr_accessor).with(:foo)
      described_class.attribute(attr_name, options)
      expect(described_class.attributes).to include(attr_name: :foo, options: options)
    end

    after { described_class.attributes.delete(attr_name: attr_name, options: options) }
  end

  describe '.association' do
    let(:assoc_name) { :foo }

    it 'defines an method with the assoc_name' do
      expect(described_class).to receive(:define_method).with(:foo)
      described_class.association(assoc_name)
    end
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
    let(:attributes) { [{ attr_name: :foo, options: {} }, { attr_name: :bar, options: {} }] }

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

    context 'when the attribute is an id' do
      let(:attributes) { [{ attr_name: :foo, options: { type: :id } }] }

      it 'calls on setter for each attribute' do
        expect(subject).to receive(:public_send).with('foo=', 'foo')
        expect(subject).to receive(:id=).with('foo')
        allow_any_instance_of(described_class).to receive(:initialize_attributes).and_call_original

        subject.initialize_attributes
      end
    end
  end
end
