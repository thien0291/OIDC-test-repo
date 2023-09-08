class Transaction::Process
  extend ApplicationService

  def initialize(credit_token, transaction)
    @credit_token = credit_token
    @transaction = transaction
  end

  def call
    # consider to put it into db transaction
    set_transation_to_processing_status
    charge_money_from_credit_token
    set_status_to_completed

    @transaction
  end

  private

  def set_transation_to_processing_status
    @transaction.credit_token = @credit_token
    raise "status error: should be pending" unless @transaction.status == "pending"

    @transaction.status = "processing"
    @transaction.save
  end

  # make an API call to pressingly to charge user.
  def charge_money_from_credit_token
    ref_transaction = CreditToken::Charge.call(@credit_token, @transaction.amount, @transaction.currency, description)
    @transaction.extra_info ||= {}
    @transaction.extra_info[:ref_transaction] = ref_transaction
    @transaction.ref_transaction_id = ref_transaction["id"]
  rescue => e
    @transaction.status = "failed"

    @transaction.extra_info[:error] = e.message
    @transaction.save
    raise e
  end

  def set_status_to_completed
    @transaction.status = "completed"
    @transaction.save
  end

  def description
    if @transaction.related_object_type == "AccessPass"
      return  "You've purchased \"#{transaction.related_object.package_name}\" package"
    end

    "You've purchased a new article: #{transaction.related_object.title}"
  end
end
