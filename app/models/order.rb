# Order object. represent apstract good.

class Order < ApplicationRecord
  belongs_to :invoice

  has_one :user,
          through: :invoice

  has_many :transactions,
            autosave: true

  enum :status, {
                  pending:   'pending',
                  paid:      'paid',
                  cancelled: 'cancelled'
                }

  validates :price_cents,
            presence: true,
            numericality: {
              only_integer: true,
              greater_than: 0
            }

  before_save :before_save_callback

  def before_save_callback
    if status_was == 'pending'
      if paid?
        transactions.new(amount_cents: -price_cents, invoice:)
      elsif cancelled?
        # do not create transation
      end
    elsif status_was == 'paid'
      if cancelled?
        transactions.new(amount_cents: price_cents, invoice:)
      elsif pending?
        errors.add(:status, 'can not revert status to pending')
      end
    elsif status_was == 'cancelled'
      errors.add(:status, 'can not change cancelled order')
    end
  end
end