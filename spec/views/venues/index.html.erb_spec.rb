require 'spec_helper'

describe "venues/index" do
  it "renders search form" do
    render
    expect(rendered).to include("Find Venues!")
  end
  
  it "renders a map"
end
