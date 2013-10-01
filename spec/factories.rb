FactoryGirl.define do
  factory :venue do    
    name "Fox Theater"
    lat 37.80809019289311
    lng -122.27061431370356
    url "http://www.thefoxoakland.com"
    phone "(510) 302-2277"
    
    initialize_with { new(name: name, lat: lat, lng: lng, url: url, phone: phone) }
  end
  
  factory :invalid_venue, class: Venue do    
    name "Fox Theater"
    lat 37.80809019289311
    
    initialize_with { new(name: name, lat: lat) }
  end
end
