FactoryBot.define do
  factory :merchant do
    sequence :name do |n|
      "Jane Doe #{n}"
    end
  end
end
