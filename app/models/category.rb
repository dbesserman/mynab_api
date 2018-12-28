class Category < ApplicationRecord
  has_many :budget_events
  has_many :transactions
  belongs_to :group
  validates_presence_of :name, :group
end
