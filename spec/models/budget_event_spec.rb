require 'rails_helper'

RSpec.describe BudgetEvent, type: :model do
  specify { should belong_to(:category) }
  specify { should validate_presence_of(:event_type) }
  specify { should validate_presence_of(:month_index) }
  specify { should validate_presence_of(:year) }
  specify { should validate_presence_of(:variation) }
end
