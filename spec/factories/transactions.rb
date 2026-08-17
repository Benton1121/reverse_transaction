FactoryBot.define do
  factory :transaction do
    association :order
    association :invoice
  end
end
