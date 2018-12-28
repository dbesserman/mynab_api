require 'rails_helper'

RSpec.describe TransactionSerializer do
  describe '.render' do
    context 'when a valid transaction is passed in' do
      let(:date_formatter) { double(DateFormatter) }
      let(:group) { Fabricate(:group) }
      let(:category) { Fabricate(:category, name: 'Phone / Internet', group_id: group.id) }
      let(:frozen_time) { Time.parse('2018-12-27 12:03:56') }
      let(:transaction) { Fabricate(:transaction, id: 4, account: 'bnp', payee: 'SFR', variation: -1000, date_time: frozen_time, cleared: false, category_id: category.id) }
      let(:expected_response) do
        {
          id: 4,
          account: 'bnp',
          category: 'Phone / Internet',
          cleared: false,
          date: 'Thu Dec 27 11:03:56 2018',
          payee: 'SFR',
          variation: -1000,
        }.to_json
      end

      before do
        allow(DateFormatter).to receive(:new).with(frozen_time).and_return(date_formatter)
        allow(date_formatter).to receive(:perform).and_return('Thu Dec 27 11:03:56 2018')
      end

      after { described_class.render(transaction) }

      specify { expect(DateFormatter).to receive(:new).with(frozen_time).exactly(1).times }
      specify { expect(date_formatter).to receive(:perform).exactly(1).times }
      specify { expect(described_class.render(transaction)).to eq(expected_response) }
    end

    context 'when a collection of transactions is passed in' do
      let(:date_formatter_a) { double(DateFormatter) }
      let(:date_formatter_b) { double(DateFormatter) }
      let(:group) { Fabricate(:group) }
      let(:category_a) { Fabricate(:category, name: 'Phone / Internet', group_id: group.id) }
      let(:category_b) { Fabricate(:category, name: 'Taxes', group_id: group.id) }
      let(:frozen_time_a) { Time.parse('2018-12-27 12:03:56') }
      let(:frozen_time_b) { Time.parse('2018-12-27 16:52:03') }
      let(:transaction_a) { Fabricate(:transaction, id: 4, account: 'bnp', payee: 'SFR', variation: -1000, date_time: frozen_time_a, cleared: false, category_id: category_a.id) }
      let(:transaction_b) { Fabricate(:transaction, id: 5, account: 'bnp', payee: 'Emmanuel Macron', variation: -10000, date_time: frozen_time_b, cleared: true, category_id: category_b.id) }
      let(:transactions) { [transaction_a, transaction_b] }
      let(:expected_response) do
        [
          {
            id: 4,
            account: 'bnp',
            category: 'Phone / Internet',
            cleared: false,
            date: 'Thu Dec 27 11:03:56 2018',
            payee: 'SFR',
            variation: -1000,
          },
          {
            id: 5,
            account: 'bnp',
            category: 'Taxes',
            cleared: true,
            date: 'Thu Dec 27 15:52:03 2018',
            payee: 'Emmanuel Macron',
            variation: -10000,
          },
        ].to_json
      end

      before do
        allow(DateFormatter).to receive(:new).with(frozen_time_a).and_return(date_formatter_a)
        allow(DateFormatter).to receive(:new).with(frozen_time_b).and_return(date_formatter_b)
        allow(date_formatter_a).to receive(:perform).and_return('Thu Dec 27 11:03:56 2018')
        allow(date_formatter_b).to receive(:perform).and_return('Thu Dec 27 15:52:03 2018')
      end

      after { described_class.render(transactions) }

      specify { expect(DateFormatter).to receive(:new).with(frozen_time_a).exactly(1).times }
      specify { expect(DateFormatter).to receive(:new).with(frozen_time_b).exactly(1).times }
      specify { expect(date_formatter_a).to receive(:perform).exactly(1).times }
      specify { expect(date_formatter_b).to receive(:perform).exactly(1).times }
      specify { expect(described_class.render(transactions)).to eq(expected_response) }
    end
  end
end
