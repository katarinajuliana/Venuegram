require 'spec_helper'

describe "venues/index" do
  it "renders search form" do
    render :layout => "layouts/application", :template => "venues/index"
    expect(rendered).to include("Find Venues!")
  end
  
  it "renders a map" do
    render
    expect(rendered).to have_selector("#map-canvas")
  end
  
  it "renders a venue detail box" do
    render
    expect(rendered).to have_selector("#venue-well")
  end
end
