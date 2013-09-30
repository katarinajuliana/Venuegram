require 'spec_helper'

describe "venues/_feed" do
  it "renders a modal" do
    render
    expect(rendered).to have_selector(".modal")
  end
  
  it "renders a carousel" do
    render
    expect(rendered).to have_selector(".carousel")
  end
end