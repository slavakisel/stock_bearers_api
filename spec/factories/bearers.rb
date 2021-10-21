FactoryBot.define do
  factory :bearer do
    sequence(:name) { |n| "Bearer #{n}" }
  end
end
