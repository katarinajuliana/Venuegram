require 'spec_helper'

describe VenuesController do

  describe "GET '#index'" do
    it "returns http success" do
      get :index
      expect(response).to be_success
      expect(response.status).to eq(200)
    end
    
    it "renders the index template" do
      get :index
      expect(response).to render_template("index")
    end
  end

  describe "GET '#show'" do
    let(:venue) { Venue.new("4abc421df964a520ef8620e3", "Fox Theater", 
      37.80809019289311, -122.27061431370356, "http://www.thefoxoakland.com", 
      "(510) 302-2277") }
    
    it "returns http success" do
      get :show, id: venue.id
      expect(response).to be_success
      expect(response.status).to eq(200)
    end
    
    it "renders the show template" do
      get :show, id: venue.id
      expect(response).to render_template("show")
    end
    
    it "assigns the requested video to @venue" do
      get :show, id: venue.id
      expect(assigns(:venue).id).to eq(venue.id)
      expect(assigns(:venue).name).to eq(venue.name)
      expect(assigns(:venue).lat).to eq(venue.lat)
      expect(assigns(:venue).lng).to eq(venue.lng)
    end
  end
end