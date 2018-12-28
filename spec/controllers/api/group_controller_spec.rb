require 'rails_helper'

RSpec.describe Api::TransactionsController do
  describe '.index' do
    context "when there's no transactions in the database" do
      let(:serialized_data) { [].to_json }

      before { allow(TransactionSerializer).to receive(:render).with([]).and_return(serialized_data) }

      context do
        after { get :index }

        specify { expect(TransactionSerializer).to receive(:render).with([]) }
      end

      context do
        before { get :index }

        specify { expect(response).to have_http_status(200) }
        specify { expect(response.body).to eq(serialized_data) }
        specify { expect(response.header['Content-Type']).to eq('application/json; charset=utf-8') }
      end
    end

    context "when there's one transaction in the database" do
      let(:group) { Fabricate(:group) }
      let(:category) { Fabricate(:category, name: 'Taxes', group_id: group.id) }
      let(:transaction) do
        Fabricate(:transaction, {
          id: 5, account: 'bnp', payee: 'Emmanuel Macron', variation: -10000, category_id: category.id,
          date_time: Time.parse('2018-12-27 12:03:56'), cleared: false
        })
      end
      let(:serialized_data) do
        [
          {
            id: 5,
            account: 'bnp',
            category: 'Taxes',
            cleared: false,
            date: "Thu Dec 27 12:03:56 2018",
            payee: 'Emmanuel Macron',
            variation: -10000
          }
        ].to_json
      end

      before { allow(TransactionSerializer).to receive(:render).with([transaction]).and_return(serialized_data) }

      context do
        after { get :index }

        specify { expect(TransactionSerializer).to receive(:render).with([transaction]) }
      end

      context do
        before { get :index }

        specify { expect(response).to have_http_status(200) }
        specify { expect(response.body).to eq(serialized_data) }
        specify { expect(response.header['Content-Type']).to eq('application/json; charset=utf-8') }
      end
    end

    context "when there's many transactions in the database" do
      let(:group) { Fabricate(:group) }
      let(:category) { Fabricate(:category, name: 'Taxes', group_id: group.id) }
      let(:transaction_a) do
        Fabricate(:transaction, {
          id: 5, account: 'bnp', payee: 'Emmanuel Macron', variation: -10000, category_id: category.id,
          date_time: Time.parse('2018-12-27 12:03:56'), cleared: false
        })
      end
      let(:transaction_b) do
        Fabricate(:transaction, {
          id: 6, account: 'bnp', payee: 'Emmanuel Macron', variation: -1000, category_id: category.id,
          date_time: Time.parse('2018-12-27 12:03:56'), cleared: false
        })
      end
      let(:transactions) { [transaction_a, transaction_b] }
      let(:serialized_data) do
        [
          {
            id: 5,
            account: 'bnp',
            category: 'Taxes',
            cleared: false,
            date: "Thu Dec 27 12:03:56 2018",
            payee: 'Emmanuel Macron',
            variation: -10000
          },
          {
            id: 6,
            account: 'bnp',
            category: 'Taxes',
            cleared: false,
            date: "Thu Dec 27 12:03:56 2018",
            payee: 'Emmanuel Macron',
            variation: -10000
          }
        ].to_json
      end

      before { allow(TransactionSerializer).to receive(:render).with(transactions).and_return(serialized_data) }

      context do
        after { get :index }

        specify { expect(TransactionSerializer).to receive(:render).with(transactions) }
      end

      context do
        before { get :index }

        specify { expect(response).to have_http_status(200) }
        specify { expect(response.body).to eq(serialized_data) }
        specify { expect(response.header['Content-Type']).to eq('application/json; charset=utf-8') }
      end
    end
  end
end
