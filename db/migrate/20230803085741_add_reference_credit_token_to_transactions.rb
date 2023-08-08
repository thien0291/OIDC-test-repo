class AddReferenceCreditTokenToTransactions < ActiveRecord::Migration[7.0]
  def change
    add_reference :transactions, :credit_token, type: :uuid, null: true, default: nil, foreign_key: true
  end
end
