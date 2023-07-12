Rails.application.config.middleware.use OmniAuth::Builder do
  provider :developer unless Rails.env.production?
end

OmniAuth::AuthenticityTokenProtection.default_options(key: "csrf.token", authenticity_param: "_csrf")
