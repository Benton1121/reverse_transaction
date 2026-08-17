# Transaction inside invoice.

class Transaction < ApplicationRecord
  belongs_to :invoice
  belongs_to :order

  def spent?() = price_cents.negative?
  def reverse?() = price_cents.positive?
end