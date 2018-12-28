require 'rails_helper'

RSpec.describe Api::GroupsController do
  describe '.index' do
    context "when there's no groups in the database" do
      let(:serialized_data) { [].to_json }

      before { allow(GroupSerializer).to receive(:render).with([]).and_return(serialized_data) }

      context do
        after { get :index }

        specify { expect(GroupSerializer).to receive(:render).with([]) }
      end

      context do
        before { get :index }

        specify { expect(response).to have_http_status(200) }
        specify { expect(response.body).to eq(serialized_data) }
        specify { expect(response.header['Content-Type']).to eq('application/json; charset=utf-8') }
      end
    end

    context "when there's one group in the database" do
      let(:group) { Fabricate(:group, id: 1, name: 'Immediate obligations') }
      let(:serialized_data) do
        [
          {
            id: 1,
            categories: [],
            name: 'Immediate obligations'
          }
        ].to_json
      end

      before { allow(GroupSerializer).to receive(:render).with([group]).and_return(serialized_data) }

      context do
        after { get :index }

        specify { expect(GroupSerializer).to receive(:render).with([group]) }
      end

      context do
        before { get :index }

        specify { expect(response).to have_http_status(200) }
        specify { expect(response.body).to eq(serialized_data) }
        specify { expect(response.header['Content-Type']).to eq('application/json; charset=utf-8') }
      end
    end

    context "when there's many groups in the database" do
      let(:group_a) { Fabricate(:group, id: 1, name: 'Immediate obligations') }
      let(:group_b) { Fabricate(:group, id: 2, name: 'Fun money') }
      let(:groups) { [group_a, group_b] }
      let(:serialized_data) do
        [
          {
            id: 1,
            categories: [],
            name: 'Immediate obligations'
          },
          {
            id: 2,
            categories: [],
            name: 'Fun money'
          }
        ].to_json
      end

      before { allow(GroupSerializer).to receive(:render).with(groups).and_return(serialized_data) }

      context do
        after { get :index }

        specify { expect(GroupSerializer).to receive(:render).with(groups) }
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
