require 'rails_helper'

RSpec.describe TCGL::Lists::Base do
  describe '#collection' do
    let(:raw_data) { [{ foo: :bar }, { foo: :bar }] }

    before { allow(subject).to receive(:raw_data) { raw_data } }

    it 'instantiates a new model_class passing raw_data' do
      expect(TCGL::Models::Base).to receive(:new).with(foo: :bar).twice
      subject.collection
    end
  end

  describe '#raw_data' do
    let(:request_class) { double }

    before do
      allow(subject.class).to receive(:request_class) { request_class }
      allow(request_class).to receive(:new) { request_class }
    end

    it 'fetches on request_class instance' do
      expect(request_class).to receive(:fetch)
      subject.raw_data
    end
  end

  describe '#each' do
    let(:collection) { [1,2] }

    before { allow(subject).to receive(:collection) { collection } }

    it 'yields as much collection exists' do
      expect { |b| subject.each(&b) }.to yield_successive_args(1, 2)
    end
  end
end