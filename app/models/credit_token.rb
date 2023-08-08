class CreditToken < ApplicationRecord
  belongs_to :user
  has_many :transactions
  scope :active, -> { where("expired_at > ?", Time.now).where(cancelled_at: nil) }
end
