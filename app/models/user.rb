class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable

  devise :omniauthable, omniauth_providers: [:openid_connect]

  has_many :transactions
  has_many :completed_transactions, -> { where(status: "completed") }, class_name: "Transaction"
  has_many :articles, through: :completed_transactions, source: :related_object, source_type: "Article"
  has_many :access_passes, through: :completed_transactions, source: :related_object, source_type: "AccessPass"
  has_many :credit_tokens

  def self.from_omniauth(auth)
    # find_or_create_by(provider: auth.provider, uid: auth.uid) do |user|
    find_or_create_by(email: auth.info.email) do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
      user.provider = auth.provider
      user.uid = auth.uid
      # user.name = auth.info.name   # assuming the user model has a name
      # user.image = auth.info.image # assuming the user model has an image
      # If you are using confirmable and the provider(s) you use validate emails,
      # uncomment the line below to skip the confirmation emails.
      # user.skip_confirmation!
    end
  end

  def can_access?(article)
    articles.include?(article) || access_passes.active.any?
  end

  def self.latest_completed_access_pass_package_name(user_id)
    select("ap.package_name")
      .joins("JOIN transactions AS t ON users.id = t.user_id")
      .joins("JOIN access_passes AS ap ON t.related_object_id = ap.id")
      .where("t.status = 'completed' AND users.id = ?", user_id)
      .order("t.created_at DESC")
      .limit(1)
      .pluck("ap.package_name")
      .first
  end
end
