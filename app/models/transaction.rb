class Transaction < ApplicationRecord
  belongs_to :user
  belongs_to :related_object, polymorphic: true
  belongs_to :credit_token, optional: true

  enum status: { pending: "pending",
                 processing: "processing",
                 completed: "completed",
                 failed: "failed",
                 disputed: "disputed",
                 canceled: "canceled",
                 refunded: "refunded" }

  scope :sum_amount_current_month, -> {
    where("created_at >= ? AND created_at <= ? ", Time.current.beginning_of_month, Time.current.end_of_month).sum(:amount)
  }
end
