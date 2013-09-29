class VenuesController < ApplicationController
  def index
  end

  def show
    @venue = Venue.find(params[:id])
    @venue.fetch_grams
  end
end
