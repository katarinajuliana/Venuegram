require "spec_helper"

describe "the venue search process", :js => true do
  context "when no venues match search"
    it "tells user No Venues Match" do
      visit root_path
      fill_in 'Latitude & Longitude', :with => '1,1'
      fill_in 'Radius in meters', :with => '0'
      click_button 'Find Venues!'
    
      expect(page).to have_content("No Venues Match Your Search Criteria")
    end
  end
  
  context "when venues are foud" do
    xit "finds venues on map" do
      visit root_path
      fill_in 'Latitude & Longitude', :with => '37.80809019289311,-122.27061431370356'
      fill_in 'Radius in meters', :with => '1000'
      click_button 'Find Venues!'
    
      # how do I test for Google Maps markers??
    end
  end
end