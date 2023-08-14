class ErrorsController < ApplicationController
  def page_not_found
    render 'errors/page_not_found', status: :not_found
  end
end
