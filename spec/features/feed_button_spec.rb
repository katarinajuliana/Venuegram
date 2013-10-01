require "spec_helper"

describe "venue feed", :js => true do
  before :each do
    visit root_path
    fill_in 'Latitude & Longitude', with: '37.80809019289311,-122.27061431370356'
    fill_in 'Radius in meters', with: '1000'
    click_button 'Find Venues!'
    #click Google Maps Marker
  end
  
  xit "displays a modal" do
    click_button 'Venue Feed'
    
    expect(page).to have_selector("div [aria-hidden='false']")
  end
  
  xit "slides through images on a carousel" do
    click_button 'Venue Feed'
    
    img1 = find(".item.active")
    
    find(".right.carousel-control").click
    img2 = find(".item.active")
    
    expect(img1).to_not eq(img2)
  end
end
  