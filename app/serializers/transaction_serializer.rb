class TransactionSerializer < Blueprinter::Base
  identifier :id
  fields :account, :payee, :variation, :cleared
  field :category do |transaction|
    transaction.category.try(:name)
  end
  field :date do |transaction|
    DateFormatter.new(transaction.date_time).perform
  end
end
