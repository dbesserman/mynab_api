class BudgetEventSerializer < Blueprinter::Base
  identifier :id
  fields :year, :variation
  field :event_type, name: :type
  field :month_index, name: :monthIndex
end
