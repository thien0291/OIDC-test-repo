class CreditToken::Charge
  extend ApplicationService

  # return a transaction object
  def initialize(credit_token, amount, currency)
    @credit_token = credit_token
    @amount = amount
    @currency = currency
  end

  def call
    api_endpoint = "https://localhost:3000"
    api_request = RestClient::Resource.new(api_endpoint, verify_ssl: false)

    response = api_request["/credit_tokens/charge.json"].post({
      # TODO: encrypt the secret Token with secret key
      credit_token: @credit_token.secret_token,
      amount: @amount,
      currency: @currency,
    }.to_json, { :content_type => "application/json" })

    transaction = JSON.parse(response.body)
    if response.code == 200 && transaction["status"] == "completed"
      return transaction
    else
      raise "transaction status error: #{transaction["status"]}"
    end
  end

  private
end
