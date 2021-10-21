FactoryBot.define do
  factory :bearer do
    name { |n| "Bearer #{n}" }
  end
end
