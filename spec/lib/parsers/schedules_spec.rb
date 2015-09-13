require 'rails_helper'

RSpec.describe TCGL::Parsers::Schedules do
  describe '#to_hash' do
    subject { described_class.new(double) }

    let(:departures) { [1, 2, 3] }
    let(:arrivals) { [:foo, :bar, :zig] }
    let(:paths) { [:foo, :bar, :zig] }

    before do
      allow(subject).to receive(:departures) { departures }
      allow(subject).to receive(:arrivals) { arrivals }
      allow(subject).to receive(:paths) { paths }
    end

    it 'returns an array of hashes containing departure, arrival and path' do
      expect(subject.to_hash).to contain_exactly(
        { departure: 1, arrival: :foo, path: :foo },
        { departure: 2, arrival: :bar, path: :bar },
        { departure: 3, arrival: :zig, path: :zig }
      )
    end
  end

  describe '#departures' do
    subject { described_class.new(double) }

    let(:schedule_tables) { [double] }
    let(:schedule_table) { double }
    let(:schedule_rows) { [double] }
    let(:schedule_row) { double }
    let(:schedule_element) { double }
    let(:schedule_text) { double }

    before { allow(subject).to receive(:schedule_tables) { schedule_tables } }

    it 'calls on text on the right html element' do
      expect(schedule_tables).to receive(:map).and_yield(schedule_table)
      expect(schedule_table).to receive(:css).with('tr:not(.TextoTitulo)') { schedule_rows }
      expect(schedule_rows).to receive(:map).and_yield(schedule_row)
      expect(schedule_row).to receive(:css).with('td:nth-of-type(1)') { schedule_element }
      expect(schedule_element).to receive(:text) { schedule_text }
      expect(schedule_text).to receive(:flatten)

      subject.departures
    end
  end

  describe '#arrivals' do
    subject { described_class.new(double) }

    let(:schedule_tables) { [double] }
    let(:schedule_table) { double }
    let(:schedule_rows) { [double] }
    let(:schedule_row) { double }
    let(:schedule_element) { double }
    let(:schedule_text) { double }

    before { allow(subject).to receive(:schedule_tables) { schedule_tables } }

    it 'calls on text on the right html element' do
      expect(schedule_tables).to receive(:map).and_yield(schedule_table)
      expect(schedule_table).to receive(:css).with('tr:not(.TextoTitulo)') { schedule_rows }
      expect(schedule_rows).to receive(:map).and_yield(schedule_row)
      expect(schedule_row).to receive(:css).with('td:nth-of-type(3)') { schedule_element }
      expect(schedule_element).to receive(:text) { schedule_text }
      expect(schedule_text).to receive(:flatten)

      subject.arrivals
    end
  end

  describe '#paths' do
    subject { described_class.new(double) }

    let(:schedule_tables) { [double] }
    let(:schedule_table) { double }
    let(:schedule_rows) { [double] }
    let(:schedule_row) { double }
    let(:schedule_element) { double }
    let(:schedule_text) { double }

    before { allow(subject).to receive(:schedule_tables) { schedule_tables } }

    it 'calls on text on the right html element' do
      expect(schedule_tables).to receive(:map).and_yield(schedule_table)
      expect(schedule_table).to receive(:css).with('tr:not(.TextoTitulo)') { schedule_rows }
      expect(schedule_rows).to receive(:map).and_yield(schedule_row)
      expect(schedule_row).to receive(:css).with('td:nth-of-type(5)') { schedule_element }
      expect(schedule_element).to receive(:text) { schedule_text }
      expect(schedule_text).to receive(:flatten)

      subject.paths
    end
  end

  describe '#schedule_tables' do
    subject { described_class.new(double) }

    let(:nokogiri_html) { double }

    before { allow(subject).to receive(:nokogiri_html) { nokogiri_html } }

    it 'calls on css in nokogiri_html' do
      expect(nokogiri_html).to receive(:css).with('.tabHoraria')
      subject.schedule_tables
    end
  end

  describe '#nokogiri_html' do
    subject { described_class.new(raw_body) }

    let(:raw_body) { double }

    it 'parses raw_body with Nokogiri::HTML' do
      expect(Nokogiri).to receive(:HTML).with(raw_body)
      subject.nokogiri_html
    end
  end
end
