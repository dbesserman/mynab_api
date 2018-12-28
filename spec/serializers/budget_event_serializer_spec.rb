require 'rails_helper'

RSpec.describe BudgetEventSerializer do
  describe '.render' do
    context 'when a valid budget_event is passed in' do
      let(:group) { Fabricate(:group) }
      let(:category) { Fabricate(:category, group_id: group.id) }
      let(:budget_event) { Fabricate(:budget_event, id: 3, year: 2018, variation: 3000, event_type: 'budget', month_index: 4, category_id: category.id) }
      let(:expected_return_value) do
        {
          id: 3,
          monthIndex: 4,
          type: 'budget',
          variation: 3000,
          year: 2018
        }.to_json
      end

      specify { expect(described_class.render(budget_event)).to eq(expected_return_value) }
    end

    context 'when a collection of valid budget events is passed in' do
      let(:group) { Fabricate(:group) }
      let(:category) { Fabricate(:category, group_id: group.id) }
      let(:budget_event_a) { Fabricate(:budget_event, id: 3, year: 2018, variation: 3000, event_type: 'budget', month_index: 4, category_id: category.id) }
      let(:budget_event_b) { Fabricate(:budget_event, id: 4, year: 2019, variation: -1000, event_type: 'budget', month_index: 2, category_id: category.id) }
      let(:budget_events) { [budget_event_a, budget_event_b] }
      let(:expected_return_value) do
        [
          {
            id: 3,
            monthIndex: 4,
            type: 'budget',
            variation: 3000,
            year: 2018
          },
          {
            id: 4,
            monthIndex: 2,
            type: 'budget',
            variation: -1000,
            year: 2019
          }
        ].to_json
      end

      specify { expect(described_class.render(budget_events)).to eq(expected_return_value) }
    end
  end
end
