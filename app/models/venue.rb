class Venue
  attr_reader :name, :lat, :lng, :url, :phone, :grams
  
  def initialize(name, lat, lng, url, phone)
    @name, @url, @phone, @lat, @lng  = name, url, phone, lat, lng
  end
  
  def fetch_grams
    @grams = []
    
    response = RestClient.get 'https://api.instagram.com/v1/media/search', 
      { :params => { :client_id => ENV["INSTA_ID"], :lat => @lat, :lng => @lng } }
      
    JSON.parse(response)["data"].each do |gram|
      @grams << gram["images"]["thumbnail"]["url"]
    end
  end
end