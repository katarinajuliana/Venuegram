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
    let(:venue) { FactoryGirl.build(:venue) }
      
    before :each do
      get :show, id: "4abc421df964a520ef8620e3"
    end
    
    it "returns http success" do
      expect(response).to be_success
      expect(response.status).to eq(200)
    end
    
    it "assigns the requested venue to @venue" do
      expect(assigns(:venue).name).to eq(venue.name)
      expect(assigns(:venue).lat).to eq(venue.lat)
      expect(assigns(:venue).lng).to eq(venue.lng)
    end
    
    it "fetches instagrams" do
      expect(assigns(:venue).grams.length).to be > 0
    end
  end
end