class ArticlesController < ApplicationController
  before_action :set_article, only: %i[ show edit update destroy ]

  # GET /articles or /articles.json
  def index
    @articles = Article.order(created_at: :desc).all
  end

  # GET /articles/1 or /articles/1.json
  def show
    # return redirect_to "https://pressingly-account.onrender.com/credit_tokens/issue?encrypted_params=eyJvcmdhbml6YXRpb25faWQiOiJjM2YyMGY4MS05MmE4LTQ5NTEtYmM3MC1jNTYzMTVhM2M3NjciLCJyZXR1cm5fdXJsIjoiaHR0cHM6Ly9sb2NhbGhvc3Q6MzAwNS9jcmVkaXRfdG9rZW5zL2MwZTA1NTBkLWI3MmUtNGE5OC1iODQ5LTg5YTNlZjI2YjBlOC9jYWxsYmFjaz90cmFuc2FjdGlvbl9pZD01Y2RjYWVmZC0zZThkLTQzOTgtODAwNi1hMzc5ZTQ3M2M2MWIiLCJjYW5jZWxfdXJsIjoiaHR0cHM6Ly9sb2NhbGhvc3Q6MzAwNS9jcmVkaXRfdG9rZW5zL2MwZTA1NTBkLWI3MmUtNGE5OC1iODQ5LTg5YTNlZjI2YjBlOC9jYWxsYmFjaz90cmFuc2FjdGlvbl9pZD01Y2RjYWVmZC0zZThkLTQzOTgtODAwNi1hMzc5ZTQ3M2M2MWIifQ==&organization_id=c3f20f81-92a8-4951-bc70-c56315a3c767",
    #                    allow_other_host: true,
    #                    turbolinks: false

    if current_user && (not current_user.can_access?(@article))
      transaction_params = {
        user_id: current_user.id,
        related_object_type: "Article",
        related_object_id: @article.id,
        extra_info: {
          return_url: article_url(@article),
        }.to_json,
      }

      request.params[:transaction] = transaction_params
      res = TransactionsController.dispatch(:create, request, response)

      return res
      # return res.last
      # return redirect_to "https://pressingly-account.onrender.com/credit_tokens/issue?encrypted_params=eyJvcmdhbml6YXRpb25faWQiOiJjM2YyMGY4MS05MmE4LTQ5NTEtYmM3MC1jNTYzMTVhM2M3NjciLCJyZXR1cm5fdXJsIjoiaHR0cHM6Ly9sb2NhbGhvc3Q6MzAwNS9jcmVkaXRfdG9rZW5zL2MwZTA1NTBkLWI3MmUtNGE5OC1iODQ5LTg5YTNlZjI2YjBlOC9jYWxsYmFjaz90cmFuc2FjdGlvbl9pZD01Y2RjYWVmZC0zZThkLTQzOTgtODAwNi1hMzc5ZTQ3M2M2MWIiLCJjYW5jZWxfdXJsIjoiaHR0cHM6Ly9sb2NhbGhvc3Q6MzAwNS9jcmVkaXRfdG9rZW5zL2MwZTA1NTBkLWI3MmUtNGE5OC1iODQ5LTg5YTNlZjI2YjBlOC9jYWxsYmFjaz90cmFuc2FjdGlvbl9pZD01Y2RjYWVmZC0zZThkLTQzOTgtODAwNi1hMzc5ZTQ3M2M2MWIifQ==&organization_id=c3f20f81-92a8-4951-bc70-c56315a3c767", allow_other_host: true, turbolinks: false
    end

    render json: { success: :ok }
  end

  # GET /articles/new
  def new
    @article = Article.new
  end

  # GET /articles/1/edit
  def edit
  end

  # POST /articles or /articles.json
  def create
    @article = Article.new(article_params)

    respond_to do |format|
      if @article.save
        format.html { redirect_to article_url(@article), notice: "Article was successfully created." }
        format.json { render :show, status: :created, location: @article }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /articles/1 or /articles/1.json
  def update
    respond_to do |format|
      if @article.update(article_params)
        format.html { redirect_to article_url(@article), notice: "Article was successfully updated." }
        format.json { render :show, status: :ok, location: @article }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /articles/1 or /articles/1.json
  def destroy
    @article.destroy

    respond_to do |format|
      format.html { redirect_to articles_url, notice: "Article was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_article
    @article = Article.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def article_params
    params.require(:article).permit(:title, :summary, :content, :price, :currency, :tag_list)
  end
end
