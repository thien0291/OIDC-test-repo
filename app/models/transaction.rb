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
    current_month = Time.current.month
    current_year = Time.current.year

    where("EXTRACT(MONTH FROM created_at) = ? AND EXTRACT(YEAR FROM created_at) = ?", current_month, current_year)
      .sum(:amount)
  }

  scope :latest_completed_access_pass_package_name, -> {
    joins("JOIN access_passes AS ap ON transactions.related_object_id = ap.id")
      .where("transactions.status = 'completed'")
      .order("transactions.created_at DESC")
      .limit(1)
      .pluck("ap.package_name")
      .first
  }
end
