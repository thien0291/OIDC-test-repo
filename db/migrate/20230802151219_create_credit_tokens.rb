class CreateCreditTokens < ActiveRecord::Migration[7.0]
  def change
    create_table :credit_tokens, id: :uuid do |t|
      t.references :user, type: :uuid, null: false, foreign_key: true
      t.string :provider, default: "pressingly"
      t.string :secret_token, null: false, index: { unique: true }, comment: "The secret token that is used to access the credit token."
      t.decimal :threshold, null: false, default: 5.0, precision: 12, scale: 6, comment: "The amount of credit that is available to the user."
      t.datetime :expired_at, null: false, comment: "The date and time when the credit token expires."
      t.datetime :cancelled_at, null: true, comment: "The date and time when the credit token was cancelled."

      t.timestamps
    end
  end
end
