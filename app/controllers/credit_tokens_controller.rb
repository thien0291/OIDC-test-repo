class CreditTokensController < ApplicationController
  before_action :set_credit_token, only: %i[ show edit update destroy callback ]
  # allow to redirect post from transaction controller.
  skip_before_action :verify_authenticity_token, only: %i[ create ]

  # GET /credit_tokens or /credit_tokens.json
  def index
    @credit_tokens = CreditToken.all
  end

  # GET /credit_tokens/1 or /credit_tokens/1.json
  def show
  end

  # GET /credit_tokens/new
  def new
    @credit_token = CreditToken.new
  end

  # GET /credit_tokens/1/edit
  def edit
  end

  # POST /credit_tokens or /credit_tokens.json
  def create
    credit_token = CreditToken.create({
      user_id: current_user.id,
      provider: "pressingly",
      secret_token: Random.hex(32),
      expired_at: 1.month.ago,
    })

    # the url we will process after successfull issue new credit token
    transaction_id = params["transaction_id"]

    redirect_post("https://localhost:3000/credit_tokens",
                  params: {
                    "organization_id": "3c6c4cbe-d2ac-4aad-927e-0eab96f74262",
                    "return_url": "https://localhost:3005/credit_tokens/#{credit_token.id}/callback?transaction_id=#{transaction_id}",
                    "cancel_url": "https://localhost:3005/credit_tokens/cancel?id=#{credit_token.id}",
                  })

    # @credit_token = CreditToken.new(credit_token_params)

    # if @credit_token.save
    #   redirect_post("https://localhost:3000/credit_tokens/new",
    #                 params: {
    #                   "organization_id": "3c6c4cbe-d2ac-4aad-927e-0eab96f74262",
    #                   "return_url": confirm_transaction_url(@transaction, provider: "pressingly"),
    #                   "cancel_url": "https://localhost:3005/transactions/cancel?transaction_id=#{@transaction.id}",
    #                 })
    # else
    #   redirect_to :back
    # end
  end

  def callback
    pressingly_secret_key = "73021de40b5d2ebabba7a7310ed035a9"
    encrypted_credit_token = Base64.decode64(params[:encrypted_credit_token])

    secret_token = ActiveSupport::MessageEncryptor
      .new(pressingly_secret_key)
      .decrypt_and_verify(encrypted_credit_token)

    @credit_token.update(secret_token: secret_token)
    # TODO: Fetch credit token information from pressingly
    @credit_token.update(expired_at: 1.month.from_now)

    # fetch information

    # back to the operation page
    if params["transaction_id"]
      @transaction = current_user.transactions.find(params["transaction_id"])
      return redirect_post charge_transaction_path(@transaction)
    end

    redirect_to transaction.extra_info[:return_url], alert: "Transaction failed"
  end

  # PATCH/PUT /credit_tokens/1 or /credit_tokens/1.json
  def update
    respond_to do |format|
      if @credit_token.update(credit_token_params)
        format.html { redirect_to credit_token_url(@credit_token), notice: "Credit token was successfully updated." }
        format.json { render :show, status: :ok, location: @credit_token }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @credit_token.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /credit_tokens/1 or /credit_tokens/1.json
  def destroy
    @credit_token.destroy

    respond_to do |format|
      format.html { redirect_to credit_tokens_url, notice: "Credit token was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_credit_token
    @credit_token = current_user.credit_tokens.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def credit_token_params
    params.require(:credit_token).permit(:user_id, :provider, :token, :threshold, :expired_at, :cancelled_at, :hourly_threshold, :daily_threshold, :weekly_threshold, :monthly_threshold, :transaction_threshold)
  end
end
