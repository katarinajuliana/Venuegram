require 'spec_helper'

describe "venues/show" do
  let(:venue) { Venue.new("4abc421df964a520ef8620e3", "Fox Theater", 
    37.80809019289311, -122.27061431370356, "http://www.thefoxoakland.com", 
    "(510) 302-2277") }
    
  before :each do
    assign(:venue, venue)
    venue.fetch_grams
  end
    
  it "renders search form" do
    render :layout => "layouts/application", :template => "venues/index"
    expect(rendered).to include("Find Venues!")
  end
  
  it "renders a map" do
    render
    expect(view).to render_template("venues/_map")
  end
  
  it "displays venue info" do
    render
    expect(rendered).to include(venue.name)
    expect(rendered).to include(venue.url)
    expect(rendered).to include(venue.phone)
  end
end