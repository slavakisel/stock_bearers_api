FactoryBot.define do
  factory :stock do
    name { |n| "Stock #{n}" }
    bearer
  end
end
