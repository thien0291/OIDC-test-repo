class CategoriesController < ApplicationController
  def show
    category = CATEGORIES.find { |item| item[:id] == params[:id] }
    @category_name = category[:name]
    @category_id = category[:id]

    @articles_by_category = Article.tagged_with(@category_name.downcase).paginate(page: params[:page], per_page: 5)
  end
end
