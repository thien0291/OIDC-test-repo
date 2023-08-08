class AccessPass < ApplicationRecord
  PRICES = { "1 day" => 1, "1 week" => 3, "1 month" => 6, "1 year" => 50 }.freeze

  scope :active, -> { where(valid_from: ..Time.now).where(valid_until: Time.now..) }

  def price
    PRICES[package_name]
  end

  def currency
    "USD"
  end
end
