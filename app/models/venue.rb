class Venue
  attr_reader :id, :name, :lat, :lng, :url, :phone, :grams
  
  def initialize(id, name, lat, lng, url, phone)
    @id, @name, @url, @phone, @lat, @lng = id, name, url, phone, lat, lng
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