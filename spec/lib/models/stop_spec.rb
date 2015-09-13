require 'rails_helper'

RSpec.describe TCGL::Models::Line do
  describe 'Attributes' do
    subject { described_class.new(object) }

    let(:code) { double }
    let(:title) { double }

    let(:object) { { code: code, title: title } }

    it { expect(subject.id).to eq code }
    it { expect(subject.code).to eq code }
    it { expect(subject.title).to eq title }
  end
end
