require 'rails_helper'

RSpec.describe Transaction, type: :model do
  specify { should belong_to(:category) }
  specify { should validate_presence_of(:account) }
  specify { should validate_presence_of(:payee) }
  specify { should validate_presence_of(:category) }
  specify { should validate_presence_of(:variation) }
  specify { should validate_presence_of(:date_time) }
end
