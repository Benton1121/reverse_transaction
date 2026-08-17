# Transaction inside invoice.

class Transaction < ApplicationRecord
  belongs_to :invoice
  belongs_to :order

  def spent?() = amount_cents.negative?
  def reverse?() = amount_cents.positive?
end