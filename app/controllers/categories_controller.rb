class CategoriesController < ApplicationController
  def show
    @category_id = params[:id]
    category = CATEGORIES.find { |item| item[:id] == @category_id }

    @articles_by_category = Article.tagged_with(category[:name].downcase)
  end
end
