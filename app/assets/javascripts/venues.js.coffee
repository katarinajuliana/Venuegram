loadScript = ->
  window.mapCallback = ->
    setMap()
  
  script      = document.createElement("script")
  script.type = "text/javascript"
  script.src  = "https://maps.googleapis.com/maps/api/js?v=3&sensor=false&callback=mapCallback"
  document.body.appendChild(script)
  
markerSuccessCallback = (response) -> 
  h3 = $("<h3>").html(response.name)
  p  = $("<p>").addClass("lead")
  a  = $("<a href='" + response.url + "'>").html(response.url)
  br = $("<br><t>").html(response.phone)
  
  $(p).append(a)
  $(p).append(br)
  $("#venue-panel").empty().append(h3)
  $("#venue-panel").append(p)
  
  window.grams = response.grams

  for gram in window.grams
    img = $("<img src='" + gram["thumb"] + "'>").addClass("thumb")
    $("#venue-panel").append(img)
    
  $("#venue-well").css("visibility", "visible")
  
onReady = ->
  loadScript()
  
  $("#search-btn").on "click", (event) ->
    event.preventDefault()
    $("#lat-lng").parent().removeClass("has-error")
    $("#radius").parent().removeClass("has-error")
    $("#venue-errors").empty()
  
    location = $("#lat-lng").val()
    radius   = $("#radius").val()

    if location == ""
      $("#lat-lng").parent().addClass("has-error")
    if radius == "" 
      $("#radius").parent().addClass("has-error")
      
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
      error: (response) ->
        $("#venue-errors").html("Hmm, did you enter valid search criteria? 
        If so, we seem to be having a problem connecting with Foursquare. 
        Sorry about that. Try again soon!")
        
    
  $("#feed-btn").on "click", (event) ->
    event.preventDefault()
    
    $("#feed-carousel").find(".carousel-inner").empty()
  
    for gram in window.grams
      div = $("<div>").addClass("item")
      
      if gram["type"] == "image"
        view = $("<img src='" + gram["view"] + "'>")
      else
        view = $("<video width='306' height='306' controls>")
        view.append($("<source src='" + gram["view"] + "' type='video/mp4'>"))
        
    
      div.append(view)
      $(".carousel-inner").append(div)
    
    $($(".carousel-inner").children()[0]).addClass("active")
    $("#feed-modal").modal("show")
  
searchSuccessCallback = (response) ->
  data = response.response.groups[0].items
  
  if data[0]
    location = new google.maps.LatLng(data[0].location.lat, data[0].location.lng)
    
    mapOptions =
      zoom: 15
      center: location
      mapTypeId: google.maps.MapTypeId.ROADMAP
    
    map = new google.maps.Map(document.getElementById("map-canvas"), mapOptions)

    for venue in data            
      marker = new google.maps.Marker
        position: new google.maps.LatLng(venue.location.lat, venue.location.lng)
        map: map
        title: venue.name
            
      setCallback = (id) ->
        google.maps.event.addListener marker, "click", ->  
          $.ajax
            url: "/venues/" + id
            type: "get"
            success: (response) ->
              markerSuccessCallback(response)
            error: (response) ->
              $("#venue-panel").empty().append("<h4>Oops, we seem to be having 
              trouble connecting with Instagram. Sorry about that. Try again 
              soon!</h4>")
              
              $("#venue-well").css("visibility", "visible")
            
      setCallback(venue.id)
      
  else
    $("#venue-errors").html("No Venues Match Your Search Criteria")
      
setMap = ->
  mapOptions =
    zoom: 15
    center: new google.maps.LatLng(37.8044, -122.2708)
    mapTypeId: google.maps.MapTypeId.ROADMAP
    
  new google.maps.Map(document.getElementById("map-canvas"), mapOptions)


$(document).ready(onReady)
$(document).on("page:load", onReady)