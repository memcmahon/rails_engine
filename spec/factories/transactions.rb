FactoryBot.define do
  factory :transaction do
    sequence(:credit_card_number) { |n| "1234323221#{n}"}
    result "success"
    invoice
  end
end
