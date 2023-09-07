class Transaction::TransactionService
  def initialize(user)
    @user = user
  end

  def create_transaction(transaction_params)
    transaction = @user.transactions.new(transaction_params)
    transaction.status = "pending"
    transaction.amount = transaction.related_object.price
    transaction.currency = "USD"
    transaction.extra_info = JSON.parse(transaction_params[:extra_info] || "{}")

    transaction.save
  end

  def charge(transaction)
    charge_with_credit_token(transaction)
  end

  private

  def update_user_subscription(transaction)
    @user.current_subscription = transaction.related_object_type == "AccessPass" ? transaction.related_object.package_name : "Pay Per Article"
    @user.save
  end

  def charge_with_credit_token(transaction)
    credit_token = @user.credit_tokens.active.first

    # Handle the case when there's no credit token
    unless credit_token
      request.params[:transaction_id] = transaction.id
      res = CreditTokensController.dispatch(:create, request, response)
      return res
    end

    Transaction::Process.call(credit_token, transaction)

    if transaction.status == "completed"
      update_user_subscription(transaction)
      return redirect_to transaction.extra_info["return_url"], notice: "Transaction completed"
    end
  end

  # charge directly over confirmation page
  def direct_charge(transaction)
    redirect_post(
      ENV["PRESSINGLY_CHARGE_URL"],
      params: {
        "order_items": [
          {
            "uid": transaction.article.to_global_id,
            "name": transaction.article.title,
            "quantity": 1,
            "price": transaction.article.price,
            "currency": "USD",
          },
        ],
        "organization_id": "3c6c4cbe-d2ac-4aad-927e-0eab96f74262",
        "return_url": confirm_transaction_url(transaction, provider: "pressingly"),
        "cancel_url": callback_credit_token_url(credit_token, transaction_id: transaction.id),
      }
    )
  end
end
