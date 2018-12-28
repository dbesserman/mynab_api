Fabricator(:budget_event) do
  id { (1..100).to_a.sample }
  year { (1987..2030).to_a.sample }
  variation { (-1000..1000).to_a.sample }
  event_type { BudgetEvent::TYPES.sample }
  month_index { (0..11).to_a.sample }
end
