class VenuesController < ApplicationController
  respond_to :json, :only => [:show]

  def show
    @venue = Venue.find(params[:id])
    @venue.fetch_grams
    
    render :json => @venue
  end
end
