class GroupSerializer < Blueprinter::Base
  identifier :id
  field :name
  association :categories, blueprint: CategorySerializer
end
