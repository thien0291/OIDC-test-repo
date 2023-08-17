class CategoriesController < ApplicationController
  def show
    category_uri = params[:category_uri]
    @category = CATEGORIES.find { |item| item[:uri] == category_uri }
    puts @category
  end
end
