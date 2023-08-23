class CategoriesController < ApplicationController
  def show
    @category_name = params[:name]
    @articles_by_category = Article.tagged_with(@category_name.downcase, on: :categories).paginate(page: params[:page], per_page: 5)
  end
end
