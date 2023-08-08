json.extract! credit_token, :id, :user_id, :provider, :token, :threshold, :expired_at, :cancelled_at, :hourly_threshold, :daily_threshold, :weekly_threshold, :monthly_threshold, :transaction_threshold, :created_at, :updated_at
json.url credit_token_url(credit_token, format: :json)
