# Order object. represent apstract good.

class Order < ApplicationRecord
  belongs_to :user

  enum :status, {
                  pending:   'pending',
                  paid:      'paid',
                  cancelled: 'cancelled'
                }

end