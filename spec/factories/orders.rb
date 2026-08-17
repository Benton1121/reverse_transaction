FactoryBot.define do
  factory :order do
    price_cents { 10_00 }
    association :invoice
  end
end
