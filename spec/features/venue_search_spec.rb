describe "the venue search process", :type => :feature do
  xit "finds venues" do
    visit '/'
    within("#venue-search") do
      fill_in 'Latitude & Longitude', :with => '37.80809019289311,-122.27061431370356'
      fill_in 'Radius in meters', :with => '900'
    end
    click_button 'Find Venues!'
    
    # result = page.evaluate_script('window.map.getBounds().contains(marker.getPosition())')
    # expect(result).to be_true
  end
end