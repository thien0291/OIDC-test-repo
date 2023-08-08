class CreateTransactions < ActiveRecord::Migration[7.0]
  def change
    create_table :transactions, id: :uuid do |t|
      t.references :user, type: :uuid, null: false, foreign_key: true
      t.references :article, type: :uuid, null: false, foreign_key: true
      t.string :provider
      t.string :provider_transaction_id
      t.string :status
      t.json :extra_info

      t.timestamps
    end
  end
end
