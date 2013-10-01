require 'active_model'

class Venue
  include ActiveModel::Model
  
  attr_accessor :name, :lat, :lng, :url, :phone, :grams
  
  validates_presence_of :name, :lat, :lng
  
  def self.find(id)
    response = RestClient.get "https://api.foursquare.com/v2/venues/#{id}", 
      { :params => { :client_id => ENV["FOUR_SQUARE_ID"],
                 :client_secret => ENV["FOUR_SQUARE_SECRET"] } }
    
    venue = JSON.parse(response)["response"]["venue"]
            
    name, url, phone = venue["name"], venue["url"], venue["contact"]["formattedPhone"]
    lat, lng         = venue["location"]["lat"], venue["location"]["lng"] 
    
    self.new(name: name, lat: lat, lng: lng, url: url, phone: phone)             
  end
  
  def fetch_grams
    @grams = []
    
    response = RestClient.get 'https://api.instagram.com/v1/media/search', 
      { params: { client_id: ENV["INSTA_ID"], lat: @lat, lng: @lng, distance: 25 } }
     
    JSON.parse(response)["data"].each do |gram|
      view = gram["#{gram["type"]}s"]["low_resolution"]["url"]
      
      @grams << { :thumb => gram["images"]["thumbnail"]["url"], :view => view, :type => gram["type"] }
    end
  end
end