class Group < ApplicationRecord
  has_many :categories
  validates_presence_of :name
end
