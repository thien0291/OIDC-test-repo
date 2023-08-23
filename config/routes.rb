Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: "users/omniauth_callbacks" }
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # should authenticate with admin_user instead

  get "/categories/:name", to: "categories#show"

  get "/subscriptions", to: "subscriptions#index"

  match "/404", to: "errors#page_not_found", via: :all

  resources :articles

  authenticate :user do
    mount Motor::Admin => "/motor_admin"
    resources :transactions do
      get "confirm", on: :member, to: "transactions#confirm"
      post "charge", on: :member, to: "transactions#charge"
    end

    resources :credit_tokens do
      get "callback", on: :member, to: "credit_tokens#callback"
    end
  end

  # Defines the root path route ("/")
  root "articles#index"
  # devise :omniauthable, omniauth_providers: %i[openid_connect]
end
