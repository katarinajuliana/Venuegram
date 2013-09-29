require "spec_helper"

describe Venue do
  let(:venue) { Venue.new("4abc421df964a520ef8620e3", "Fox Theater", 
    37.80809019289311, -122.27061431370356, "http://www.thefoxoakland.com", 
    "(510) 302-2277") }
    
  describe "#initialize" do
    it "instantiates with an id" do
      expect(venue.id).to eq("4abc421df964a520ef8620e3")
    end
    
    it "instantiates with a name" do
      expect(venue.name).to eq("Fox Theater")
    end

    it "instantiates with a latitude" do
      expect(venue.lat).to eq(37.80809019289311)
    end
    
    it "instantiates with a longitude" do
      expect(venue.lng).to eq(-122.27061431370356)
    end

    it "instantiates with a url" do
      expect(venue.url).to eq("http://www.thefoxoakland.com")
    end
    
    it "instantiates with a phone number" do
      expect(venue.phone).to eq("(510) 302-2277")
    end
  end
  
  describe "#fetch_grams" do
    it "gets thumbnail urls for venue instagrams" do
      venue.fetch_grams
      thumb_url = venue.grams.first[:thumb]
      
      expect(thumb_url).to match(/http:\/\/.*\.jpg/)
    end
    
    it "gets a view url for venue instagrams" do
      venue.fetch_grams
      view_url = venue.grams.first[:view]
      
      expect(view_url).to match(/http:\/\/.*\.jpg|http:\/\/.*\.mp4/)
    end
  end
  
  describe "::find" do
    it "returns the requested venue" do
      found = Venue.find("4abc421df964a520ef8620e3")
      expect(found.id).to eq(venue.id)
      expect(found.name).to eq(venue.name)
      expect(found.lat).to eq(venue.lat)
      expect(found.lng).to eq(venue.lng)
    end
  end
end