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
    transaction_service = Transaction::TransactionService.new(current_user)
    Rails.logger.info("Transaction Params: #{transaction_params.inspect}")
    @transaction = transaction_service.create_transaction(transaction_params)

    if @transaction
      transaction_service.charge(@transaction)
    else
      redirect_to :back
    end
    # respond_to do |format|
    #   if @transaction.save
    #     format.html { redirect_to transaction_url(@transaction), notice: "Transaction was successfully created." }
    #     format.json { render :show, status: :created, location: @transaction }
    #   else
    #     format.html { render :new, status: :unprocessable_entity }
    #     format.json { render json: @transaction.errors, status: :unprocessable_entity }
    #   end
    # end
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
end
