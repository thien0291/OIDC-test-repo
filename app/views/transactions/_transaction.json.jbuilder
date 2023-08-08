json.extract! transaction, :id, :user_id, :article_id, :provider, :provider_transaction_id, :status, :extra_info, :created_at, :updated_at
json.url transaction_url(transaction, format: :json)
