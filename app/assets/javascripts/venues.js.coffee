loadScript = ->
  window.mapCallback = ->
    setMap()
  
  script = document.createElement("script")
  script.type = "text/javascript"
  script.src = "https://maps.googleapis.com/maps/api/js?v=3&key=AIzaSyDnTPJxUbOzNQ7jF2nZYEapVHol6imO9cc&sensor=false&callback=mapCallback"
  document.body.appendChild(script)
  
onReady = ->
  loadScript()
  
  $("#venue-search").on "submit", (event) ->
    event.preventDefault()
    
    location = $("#lat-lng").val()
    radius = $("#radius").val()
    
    $.ajax
      url: "https://api.foursquare.com/v2/venues/search"
      type: "get"
      data: 
        client_id: "GEM0TN5J0VDJSL3PTEMR2J0V41F0OZJIO3ZZUMRLAUEFOFKO"
        client_secret: "F02Z2IRYUCGOHEBLKH5J3REU2XLGI0MDHZBIKV4PXWT23F0A"
        ll: location
        radius: radius
      
      success: (response) ->
        searchSuccessCallback(response)
  
searchSuccessCallback = (response) ->
  data = response.response.groups[0].items
  
  if data[0]
    location = new google.maps.LatLng(data[0].location.lat, data[0].location.lng) 
  else
    location = new google.maps.LatLng(37.80809019289311, -122.27061431370356)
    
  mapOptions =
    zoom: 15
    center: location
    mapTypeId: google.maps.MapTypeId.ROADMAP
    
  window.map = new google.maps.Map(document.getElementById("map-canvas"), mapOptions)

  for venue in data            
    window.marker = new google.maps.Marker
      position: new google.maps.LatLng(venue.location.lat, venue.location.lng)
      map: window.map
      title: venue.id
      
setMap = ->
  mapOptions =
    zoom: 15
    center: new google.maps.LatLng(37.8044, -122.2708)
    mapTypeId: google.maps.MapTypeId.ROADMAP
    
  window.map = new google.maps.Map(document.getElementById("map-canvas"), mapOptions)


$(document).ready(onReady)
$(document).on("page:load", onReady)