class Venue
  attr_reader :id, :name, :lat, :lng, :url, :phone, :grams
  
  def self.find(id)
    response = RestClient.get "https://api.foursquare.com/v2/venues/#{id}", 
      { :params => { :client_id => ENV["FOUR_SQUARE_ID"],
                 :client_secret => ENV["FOUR_SQUARE_SECRET"] } }
    
    venue = JSON.parse(response)["response"]["venue"]
            
    name, url, phone = venue["name"], venue["url"], venue["contact"]["formattedPhone"]
    lat, lng         = venue["location"]["lat"], venue["location"]["lng"] 
    
    self.new(id, name, lat, lng, url, phone)             
  end
  
  def initialize(id, name, lat, lng, url, phone)
    @id, @name, @url, @phone, @lat, @lng = id, name, url, phone, lat, lng
  end
  
  def fetch_grams
    @grams = []
    
    response = RestClient.get 'https://api.instagram.com/v1/media/search', 
      { :params => { :client_id => ENV["INSTA_ID"], :lat => @lat, :lng => @lng } }
      
    JSON.parse(response)["data"].each do |gram|
      view = gram["#{gram["type"]}s"]["low_resolution"]["url"]
      
      @grams << { :thumb => gram["images"]["thumbnail"]["url"], :view => view }
    end
  end
end