# User got invoices with balance.

class Invoice < ApplicationRecord
  belongs_to :user

  has_many :orders

  has_many :transactions,
           -> { order(:created_at) }

  def balance() = transactions.sum(:amount_cents) || 0
end