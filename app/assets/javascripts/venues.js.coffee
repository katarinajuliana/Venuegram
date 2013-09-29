loadScript = ->
  window.mapCallback = ->
    setMap()
    
  script = document.createElement("script")
  script.type = "text/javascript"
  script.src = "https://maps.googleapis.com/maps/api/js?v=3&key=AIzaSyDnTPJxUbOzNQ7jF2nZYEapVHol6imO9cc&sensor=false&callback=mapCallback"
  document.body.appendChild(script)

setMap = ->
  mapOptions =
    zoom: 8
    center: new google.maps.LatLng(37.8044, -122.2708)
    mapTypeId: google.maps.MapTypeId.ROADMAP
    
  new google.maps.Map(document.getElementById("map-canvas"), mapOptions)

$(document).ready(loadScript)
$(document).on("page:load", loadScript)