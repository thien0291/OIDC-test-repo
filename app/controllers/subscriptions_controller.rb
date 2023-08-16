class SubscriptionsController < ApplicationController
  def index
    # Use Turbo Streams to render tab content changes
    respond_to do |format|
      format.html
      format.turbo_stream
    end
  end
end
