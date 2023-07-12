class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable

  devise :omniauthable, omniauth_providers: [:openid_connect]

  def self.from_omniauth(auth)
    byebug
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
end

# https://pressingly-account.onrender.com/oauth/authorize?client_id=Vm3O1AwPLPWChwBkWPW8FRSrDP_kuZjjOckqo6EtCzY&nonce=d8d321c82af5e4b6377a0b3969619b63&redirect_uri=https%3A%2F%2Flocalhost%3A3000%2Fusers%2Fauth%2Fpressingly%2Fcallback&response_type=code&scope=openid%20email&state=9638bc50f905e9b50fff6268928630f3
