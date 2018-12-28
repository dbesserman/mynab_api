Fabricator(:transaction) do
  id { (1..100).to_a.sample }
  account { Faker::Bank.name }
  payee { Faker::Company.name }
  cleared { [true, false].sample }
  date_time { Time.now }
  variation { (-100..100).to_a.sample }
end
