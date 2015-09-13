require 'rails_helper'

RSpec.describe TCGL::Models::Concerns::Base do
  subject { described_klass.new }

  let(:described_klass) { Class.new.include(described_class) }

  describe '.model_name' do
    before { allow(described_klass).to receive(:name) { 'Foo::Bar' } }

    it { expect(described_klass.model_name).to eq 'Bar' }
  end

  describe '.all' do
    let(:list_class) { double }

    before { allow(described_klass).to receive(:list_class) { list_class } }

    it 'instantiate a list class' do
      expect(list_class).to receive(:new)
      described_klass.all
    end
  end

  describe '.where' do
    let(:options) { double }
    let(:list_class) { double }

    before { allow(described_klass).to receive(:list_class) { list_class } }

    it 'instantiate a list class' do
      expect(list_class).to receive(:new).with(options)
      described_klass.where(options)
    end
  end

  describe '.attribute' do
    let(:attr_name) { :foo }
    let(:options) { double }

    it 'defines an attr_accessor for the class and stores the attr_name on the attributes accessor' do
      expect(described_klass).to receive(:attr_accessor).with(:foo)
      described_klass.attribute(attr_name, options)
      expect(described_klass.attributes).to include(attr_name: :foo, options: options)
    end

    after { described_klass.attributes.delete(attr_name: attr_name, options: options) }
  end

  describe '.association' do
    let(:assoc_name) { :foo }

    it 'defines an method with the assoc_name' do
      expect(described_klass).to receive(:define_method).with(:foo)
      described_klass.association(assoc_name)
    end
  end

  describe '#initialize' do
    subject { described_klass.new(record) }

    let(:record) { double }

    before { allow_any_instance_of(described_klass).to receive(:initialize_attributes) }

    it 'calls on initialize_attributes and store the record' do
      expect(subject.record).to eq record
      expect(subject).to have_received(:initialize_attributes)
    end
  end

  describe '#initialize_attributes' do
    subject { described_klass.new(record) }

    let(:record) { double }
    let(:attributes) { [{ attr_name: :foo, options: {} }, { attr_name: :bar, options: {} }] }

    before do
      allow(described_klass).to receive(:attributes) { attributes }
      allow_any_instance_of(described_klass).to receive(:initialize_attributes)

      allow(record).to receive(:[]).with(:foo) { 'foo' }
      allow(record).to receive(:[]).with(:bar) { 'bar' }
    end

    it 'calls on setter for each attribute' do
      expect(subject).to receive(:public_send).with('foo=', 'foo')
      expect(subject).to receive(:public_send).with('bar=', 'bar')
      allow_any_instance_of(described_klass).to receive(:initialize_attributes).and_call_original

      subject.initialize_attributes
    end

    context 'when the attribute is an id' do
      let(:attributes) { [{ attr_name: :foo, options: { type: :id } }] }

      it 'calls on setter for each attribute' do
        expect(subject).to receive(:public_send).with('foo=', 'foo')
        expect(subject).to receive(:id=).with('foo')
        allow_any_instance_of(described_klass).to receive(:initialize_attributes).and_call_original

        subject.initialize_attributes
      end
    end
  end
end
