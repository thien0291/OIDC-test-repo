class AddReferenceTransactionIdToTransaction < ActiveRecord::Migration[7.0]
  def change
    add_column :transactions, :ref_transaction_id, :string, null: true
  end
end
