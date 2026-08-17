class RefactorTransactions < ActiveRecord::Migration[8.0]
  def change
    rename_column :transactions, :price_cents, :amount_cents
  end
end
