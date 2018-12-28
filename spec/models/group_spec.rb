require 'rails_helper'

RSpec.describe Group do
  specify { should have_many(:categories) }
  specify { should validate_presence_of(:name) }
end
