# Owner or orders.
# Users also has invoices

class User < ApplicationRecord
  has_many :orders

  has_many :invoices
end