FactoryGirl.define do
  factory :venue do    
    id "4abc421df964a520ef8620e3"
    name "Fox Theater"
    lat 37.80809019289311
    lng -122.27061431370356
    url "http://www.thefoxoakland.com"
    phone "(510) 302-2277"
    
    
    initialize_with { new(id, name, lat, lng, url, phone) }
  end
end
