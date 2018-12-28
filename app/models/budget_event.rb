class BudgetEvent < ApplicationRecord
  belongs_to :category
  validates_presence_of :event_type, :month_index, :year, :variation

  TYPES = ['budget'].freeze
end
