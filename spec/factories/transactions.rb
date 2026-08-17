FactoryBot.define do
  factory :transaction do
    association :order
    association :invoice

    amount_cents { 10_00 }
  end
end
