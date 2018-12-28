Fabricator(:category) do
  id { (1..100).to_a.sample }
  name { Faker::Dog.breed }
  group_id { nil }
end
