group_1 = Group.create!(name: 'Immediate Obligations')

cat_1a = Category.create!(
  name: 'Residence Tax', group: group_1
)
cat_1b = Category.create!(
  name: 'Rent', group: group_1
)
cat_1c = Category.create!(
  name: 'Phone / Internet', group: group_1
)

BudgetEvent.create!(
  event_type: 'budget',
  month_index: (Time.now.month - 1), 
  year: Time.now.year,
  variation: 100000,
  category: cat_1a
)

BudgetEvent.create!(
  event_type: 'budget',
  month_index: (Time.now.month - 1), 
  year: Time.now.year,
  variation: 89000,
  category: cat_1b
)

BudgetEvent.create!(
  event_type: 'budget',
  month_index: (Time.now.month - 1), 
  year: Time.now.year,
  variation: 4500,
  category: cat_1c
)

Transaction.create!(
  account: 'bnp',
  payee: 'Emmanuel Macron',
  category: cat_1a,
  variation: -100800,
  date_time: Time.now,
  cleared: false
)

Transaction.create!(
  account: 'bnp',
  payee: 'Mr. Landlord',
  category: cat_1b,
  variation: -89000,
  date_time: Time.now,
  cleared: false
)

Transaction.create!(
  account: 'bnp',
  payee: 'Numericable',
  category: cat_1c,
  variation: -3500,
  date_time: Time.now,
  cleared: false
)

Transaction.create!(
  account: 'bnp',
  payee: 'SFR',
  category: cat_1c,
  variation: -1000,
  date_time: Time.now,
  cleared: false
)
