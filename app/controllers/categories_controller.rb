class CategoriesController < ApplicationController
  def show
    @category_name = params[:category_name]

    @articles_by_category = Article.tagged_with(@category_name.downcase)
  end
end
