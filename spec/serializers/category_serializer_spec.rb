require 'rails_helper'

RSpec.describe CategorySerializer do
  describe '.render' do
    context 'when a valid category is passed in' do
      let(:group) { Fabricate(:group) }
      let(:category) { Fabricate(:category, id: 6, name: 'Phone / Internet', group_id: group.id) }
      let(:budget_event) { Fabricate(:budget_event, id: 3, year: 2018, variation: 3000, event_type: 'budget', month_index: 4, category_id: category.id) }
      let(:prepared_budget_events) { [{:id=>3, :monthIndex=>4, :type=>"budget", :variation=>3000, :year=>2018}] }
      let(:expected_return_value) do
        {
          id: 6,
          budgetEvents: [
            {
              id: 3,
              monthIndex: 4,
              type: 'budget',
              variation: 3000,
              year: 2018
            }
          ],
          name: 'Phone / Internet'
        }.to_json
      end

      before do
        allow(BudgetEventSerializer).to(
          receive(:prepare)
          .with([budget_event], view_name: :default, local_options: {})
          .and_return(prepared_budget_events)
        )
      end
      after { expect(described_class.render(category)) }

      specify { expect(BudgetEventSerializer).to receive(:prepare).with([budget_event], view_name: :default, local_options: {}) }
      specify { expect(described_class.render(category)).to eq(expected_return_value) }
    end

    context 'when a collection of valid categories is passed in' do
      let(:group) { Fabricate(:group) }
      let(:category_a) { Fabricate(:category, id: 6, name: 'Phone / Internet', group_id: group.id) }
      let(:budget_event) { Fabricate(:budget_event, id: 3, year: 2018, variation: 3000, event_type: 'budget', month_index: 4, category_id: category_a.id) }
      let(:category_b) { Fabricate(:category, id: 7, name: 'Taxes', group_id: group.id) }
      let(:categories) { [category_a, category_b] }
      let(:prepared_budget_events_a) { [{ id: 3, monthIndex: 4, type: 'budget', variation: 3000, year: 2018 }] }
      let(:prepared_budget_events_b) { [] }
      let(:expected_return_value) do
        [
          {
            id: 6,
            budgetEvents: [
              {
                id: 3,
                monthIndex: 4,
                type: 'budget',
                variation: 3000,
                year: 2018
              }
            ],
            name: 'Phone / Internet'
          },
          {
            id: 7,
            budgetEvents: [],
            name: 'Taxes'
          }
        ].to_json
      end

      before do
        allow(BudgetEventSerializer).to(
          receive(:prepare)
          .with([budget_event], view_name: :default, local_options: {})
          .and_return(prepared_budget_events_a)
        )
        allow(BudgetEventSerializer).to(
          receive(:prepare)
          .with([], view_name: :default, local_options: {})
          .and_return(prepared_budget_events_b)
        )
      end

      after { expect(described_class.render(categories)) }

      it 'prepares the budget_events for each category' do
        expect(BudgetEventSerializer).to receive(:prepare).with([budget_event], view_name: :default, local_options: {}).exactly(1).times
        expect(BudgetEventSerializer).to receive(:prepare).with([], view_name: :default, local_options: {}).exactly(1).times
      end
      specify { expect(described_class.render(categories)).to eq(expected_return_value) }
    end
  end
end

