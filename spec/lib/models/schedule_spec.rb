require 'rails_helper'

RSpec.describe TCGL::Models::Schedule do
  describe 'Attributes' do
    subject { described_class.new(object) }

    let(:departure) { double }
    let(:arrival) { double }
    let(:path) { double }

    let(:object) { { departure: departure, arrival: arrival, path: path } }

    it { expect(subject.departure).to eq departure }
    it { expect(subject.arrival).to eq arrival }
    it { expect(subject.path).to eq path }
  end
end
