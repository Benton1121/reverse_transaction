class RedefineModels < ActiveRecord::Migration[8.0]
  def change
    add_column :orders, :price_cents, :bigint, null: false, default: 0
    rename_column :orders, :user_id, :invoice_id
  end
end
