# Transaction inside invoice.

class Transaction < ApplicationRecord
  belongs_to :invoice
  belongs_to :order
end