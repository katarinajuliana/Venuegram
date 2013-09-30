loadScript = ->
  window.mapCallback = ->
    setMap()
  
  script = document.createElement("script")
  script.type = "text/javascript"
  script.src = "https://maps.googleapis.com/maps/api/js?v=3&sensor=false&callback=mapCallback"
  document.body.appendChild(script)
  
markerCallback = (response) ->
  window.grams = response.grams
  
  h3 = $("<h3>").html(response.name)
  p = $("<p>").addClass("lead")
  a = $("<a href='" + response.url + "'>").html(response.url)
  br = $("<br><t>").html(response.phone)
  
  $(p).append(a)
  $(p).append(br)
  $("#venue-panel").empty().append(h3)
  $("#venue-panel").append(p)
  
  for gram in window.grams
    img = $("<img src='" + gram["thumb"] + "'>").addClass("thumb")
    $("#venue-panel").append(img)
    
  $("#venue-well").css("visibility", "visible")
  
onReady = ->
  loadScript()
  
  $("#search-btn").on "click", (event) ->
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
    
  $("#feed-btn").on "click", (event) ->
    event.preventDefault()
    
    $("#feed-carousel").find(".carousel-inner").empty()
  
    for gram in window.grams
      div = $("<div>").addClass("item")
      img = $("<img src='" + gram["view"] + "'>")
    
      div.append(img)
      $(".carousel-inner").append(div)
    
    $($(".carousel-inner").children()[0]).addClass("active")
    $("#feed-modal").modal("show")
  
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
    
  map = new google.maps.Map(document.getElementById("map-canvas"), mapOptions)

  for venue in data            
    marker = new google.maps.Marker
      position: new google.maps.LatLng(venue.location.lat, venue.location.lng)
      map: map
    
    setCallback = (id) ->
      google.maps.event.addListener marker, "click", ->  
        $.ajax
          url: "/venues/" + id
          type: "get"
          success: (response) ->
            markerCallback(response)
            
    setCallback(venue.id)
      
setMap = ->
  mapOptions =
    zoom: 15
    center: new google.maps.LatLng(37.8044, -122.2708)
    mapTypeId: google.maps.MapTypeId.ROADMAP
    
  new google.maps.Map(document.getElementById("map-canvas"), mapOptions)


$(document).ready(onReady)
$(document).on("page:load", onReady)