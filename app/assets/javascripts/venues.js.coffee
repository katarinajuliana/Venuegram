# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/


setMap = ->
  mapOptions =
    zoom: 8
    center: new google.maps.LatLng(-34.397, 150.644)
    mapTypeId: google.maps.MapTypeId.ROADMAP
    
  new google.maps.Map(document.getElementById("map-canvas"), mapOptions)
  
loadScript = ->
  window.mapCallback = ->
    setMap()
    
  script = document.createElement("script")
  script.type = "text/javascript"
  script.src = "https://maps.googleapis.com/maps/api/js?v=3&key=AIzaSyDnTPJxUbOzNQ7jF2nZYEapVHol6imO9cc&sensor=false&callback=mapCallback"
  document.body.appendChild(script)

$(document).ready(loadScript)
$(document).on("page:load", loadScript)
