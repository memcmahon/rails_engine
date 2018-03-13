FactoryBot.define do
  factory :merchant do
    sequence(:name) { |n| "Jane Doe #{n}" }
  end
end
