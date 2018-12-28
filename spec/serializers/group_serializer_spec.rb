require 'rails_helper'

RSpec.describe GroupSerializer do
  describe '.render' do
    context 'when a valid group is passed in' do
      let(:group) { Fabricate(:group, id: 4, name: 'Immediate obligations') }
      let(:category) { Fabricate(:category, id: 2, name: 'Taxes', group_id: group.id) }
      let(:prepared_categories) { [{ id: 2, name: 'Taxes', budgetEvents: [] }] }
      let(:expected_return_value) do
        {
          id:  4,
          categories: [
            {
              id: 2,
              name: 'Taxes',
              budgetEvents: []
            }
          ],
          name: 'Immediate obligations'
        }.to_json
      end

      before do
        allow(CategorySerializer).to receive(:prepare)
          .with([category], view_name: :default, local_options: {})
          .and_return(prepared_categories)
      end

      after { described_class.render(group) }

      specify { expect(CategorySerializer).to receive(:prepare).with([category], view_name: :default, local_options: {}) }
      specify { expect(described_class.render(group)).to eq(expected_return_value) }
    end

    context 'when a collection of groups is passed in' do
      let(:group_a) { Fabricate(:group, id: 4, name: 'Immediate obligations') }
      let(:group_b) { Fabricate(:group, id: 6, name: 'Having fun') }
      let(:groups) { [group_a, group_b] }
      let(:category_a) { Fabricate(:category, id: 2, name: 'Taxes', group_id: group_a.id) }
      let(:category_b) { Fabricate(:category, id: 6, name: 'Movies', group_id: group_b.id) }
      let(:prepared_categories_a) { [{ id: 2, name: 'Taxes', budgetEvents: [] }] }
      let(:prepared_categories_b) { [{ id: 6, name: 'Movies', budgetEvents: [] }] }
      let(:expected_return_value) do
        [
          {
            id:  4,
            categories: [
              {
                id: 2,
                name: 'Taxes',
                budgetEvents: []
              }
            ],
            name: 'Immediate obligations'
          },
          {
            id:  6,
            categories: [
              {
                id: 6,
                name: 'Movies',
                budgetEvents: []
              }
            ],
            name: 'Having fun'

          }
        ].to_json
      end

      before do
        allow(CategorySerializer).to receive(:prepare)
          .with([category_a], view_name: :default, local_options: {})
          .and_return(prepared_categories_a)
        allow(CategorySerializer).to receive(:prepare)
          .with([category_b], view_name: :default, local_options: {})
          .and_return(prepared_categories_b)
      end
      after { described_class.render(groups) }

      specify { expect(CategorySerializer).to receive(:prepare).with([category_a], view_name: :default, local_options: {}).exactly(1).times }
      specify { expect(CategorySerializer).to receive(:prepare).with([category_b], view_name: :default, local_options: {}).exactly(1).times }
      specify { expect(described_class.render(groups)).to eq(expected_return_value) }
    end
  end
end
