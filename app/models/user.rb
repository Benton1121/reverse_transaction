# Owner or orders.
class User < ApplicationRecord
  has_many :orders

  has_many :invoices
end