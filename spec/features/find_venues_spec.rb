require "spec_helper"

describe "the venue search process", js: true do
  context "when invalid input/problem connecting to API" do
    it "displays an error message" do
      visit root_path
      fill_in 'Latitude & Longitude', with: 'abc'
      fill_in 'Radius in meters', with: 'abc'
      click_button 'Find Venues!'
      
      expect(page).to have_content("we seem to be having a problem connecting")
    end
  end
  
  context "when no venues match search" do
    it "tells user No Venues Match" do
      visit root_path
      fill_in 'Latitude & Longitude', with: '1,1'
      fill_in 'Radius in meters', with: '0'
      click_button 'Find Venues!'
    
      expect(page).to have_content("No Venues Match Your Search Criteria")
    end
  end
  
  context "when venues are foud" do
    before :each do 
      visit root_path
      fill_in 'Latitude & Longitude', with: '37.80809019289311,-122.27061431370356'
      fill_in 'Radius in meters', with: '1000'
      click_button 'Find Venues!'
    end
    
    xit "finds venues on map" do
      # how do I test for Google Maps markers??
    end
    
    it "doesn't display error message" do
      expect(page).to_not have_content("we seem to be having a problem connecting")
    end
  end
end