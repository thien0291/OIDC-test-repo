class AddAmountAndCurrencyToTransaction < ActiveRecord::Migration[7.0]
  def change
    add_column :transactions, :amount, :decimal, precision: 12, scale: 6, null: false, default: 0.0
    add_column :transactions, :currency, :string, null: false, default: "USD"
  end
end
