class TransactionsController < ApplicationController
  before_action :set_transaction, only: %i[ show edit update destroy charge ]
  skip_before_action :verify_authenticity_token, only: %i[ charge ]

  # GET /transactions or /transactions.json
  def index
    @transactions = Transaction.all
  end

  # GET /transactions/1 or /transactions/1.json
  def show
  end

  # GET /transactions/new
  def new
    @transaction = Transaction.new
  end

  # GET /transactions/1/edit
  def edit
  end

  # POST /transactions or /transactions.json
  def create
    @transaction = current_user.transactions.new(transaction_params)

    @transaction.status = "pending"
    @transaction.amount = @transaction.related_object.price
    @transaction.currency = "USD"
    @transaction.extra_info = JSON.parse(transaction_params[:extra_info] || "{}")

    if @transaction.save
      update_current_user_subscription
      # direct_charge
      return charge_with_credit_token
    else
      redirect_to :back
    end
  end

  # POST /transactions/:id/charge
  def charge
    charge_with_credit_token
  end

  # GET /transactions/uuid/confirm
  # link format: transaction_id, charge_id
  def confirm
    @transaction = current_user.transactions.find(params[:id])
    @transaction.update(status: "completed", provider_transaction_id: params[:charge_id])

    redirect_to article_path(@transaction.article)
  end

  # PATCH/PUT /transactions/1 or /transactions/1.json
  def update
    respond_to do |format|
      if @transaction.update(transaction_params)
        format.html { redirect_to transaction_url(@transaction), notice: "Transaction was successfully updated." }
        format.json { render :show, status: :ok, location: @transaction }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @transaction.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /transactions/1 or /transactions/1.json
  def destroy
    @transaction.destroy

    respond_to do |format|
      format.html { redirect_to transactions_url, notice: "Transaction was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_transaction
    @transaction = current_user.transactions.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def transaction_params
    params.require(:transaction).permit(:user_id, :related_object_type, :related_object_id, :extra_info)
  end

  def update_current_user_subscription
    current_user.current_subscription =
        (@transaction.related_object_type == "AccessPass") ? @transaction.related_object.package_name : "Pay Per Article"
    current_user.save
  end

  # Charge through a credit token
  def charge_with_credit_token
    credit_token = current_user.credit_tokens.active.first

    unless credit_token
      request.params[:transaction_id] = @transaction.id
      res = CreditTokensController.dispatch(:create, request, response)
      return res
    end

    Transaction::Process.call(credit_token, @transaction)

    if @transaction.status == "completed"
      return redirect_to @transaction.extra_info["return_url"], notice: "Transaction completed"
    end
  end

  # charge directly over confirmation page
  def direct_charge
    redirect_post(ENV["PRESSINGLY_CHARGE_URL"],
                  params: {
                    "order_items": [
                      {
                        "uid": @transaction.article.to_global_id,
                        "name": @transaction.article.title,
                        "quantity": 1,
                        "price": @transaction.article.price,
                        "currency": "USD",
                      },
                    ],
                    "organization_id": "3c6c4cbe-d2ac-4aad-927e-0eab96f74262",
                    "return_url": confirm_transaction_url(@transaction, provider: "pressingly"),
                    "cancel_url": callback_credit_token_url(credit_token, transaction_id: transaction_id),
                  })
  end
end
