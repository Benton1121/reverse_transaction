class CreateOrders < ActiveRecord::Migration[8.0]
  def change
    create_table :users do |t|
      t.string :user_name

      t.timestamps
    end

    create_table :invoices do |t|
      t.references :user

      t.timestamps
    end

    create_table :orders do |t|
      t.string     :order_name
      t.string     :status, null: false, default: "pending"
      t.references :user

      t.timestamps

      t.check_constraint(
        "status IN ('pending', 'paid', 'cancelled')",
        name: "orders_status_check"
      )
    end

    create_table :transactions do |t|
      t.bigint     :price_cents, null: false, default: 0
      t.references :invoice
      t.references :order

      t.timestamps
    end
  end
end
