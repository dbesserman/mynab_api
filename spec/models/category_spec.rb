require 'rails_helper'

RSpec.describe Category do
  specify { should belong_to(:group) }
  specify { should have_many(:transactions) }
  specify { should have_many(:budget_events) }
  specify { should validate_presence_of(:name) }
  specify { should validate_presence_of(:group) }
end
