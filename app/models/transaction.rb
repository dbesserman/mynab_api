class Transaction < ApplicationRecord
  validates_presence_of :account, :payee, :category, :variation, :date_time
  belongs_to :category
end
