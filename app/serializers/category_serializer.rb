class CategorySerializer < Blueprinter::Base
  identifier :id
  field :name
  association :budget_events, blueprint: BudgetEventSerializer, name: :budgetEvents
end
