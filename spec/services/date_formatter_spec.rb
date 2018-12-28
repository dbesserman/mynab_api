require 'rails_helper'

RSpec.describe DateFormatter do
  specify { expect(described_class::TIME_FORMAT).to eq('%c') }

  describe '.perform' do
    context 'when an invalid time is passed in as an argument' do
      let(:invalid_time) { nil }

      specify { expect { described_class.new(invalid_time) }.to raise_error(InvalidTimeError) }
    end

    context 'when a valid time is passed in as an argument' do
      let(:frozen_time) { Time.parse('2018-12-27 12:03:56') }
      subject { described_class.new(frozen_time) }

      specify { expect(subject.perform).to eq('Thu Dec 27 12:03:56 2018') }
    end
  end
end
