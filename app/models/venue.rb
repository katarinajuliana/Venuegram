class Venue
  attr_reader :name, :lat, :lng, :url, :phone
  
  def initialize(name, lat, lng, url, phone)
    @name, @url, @phone, @lat, @lng  = name, url, phone, lat, lng
  end
end