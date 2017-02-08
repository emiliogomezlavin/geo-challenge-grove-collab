// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .


$(function() { 
    // 
    $('form#search_form').on('submit', function(e) { 
        e.preventDefault();  
        document.getElementById("store_found").innerHTML = "";
        newStoreAddress = $("input#formatted_address").val()
        fetchData(newStoreAddress);

        // AJAX function to find the closest store of the input_address
        function fetchData(newStoreAddress) {
          var newStoreSearch = {
            formatted_address: newStoreAddress
          }
          $.post('/find_store', newStoreSearch, onSuccess);
        }

        // On Success callback that creates and assigns the elements to show the 
        // address of the store returned below the form
        function onSuccess (response){
          var div = document.createElement("div");
          // var store_found_address = document.createElement("h2");
          // store_found_address.innerHTML = response.data.address;
          div.innerHTML = "<p>The closest store to your address is at: </p><br/><h2>" + response.data.address + "</h2";
          document.getElementById("store_found").appendChild(div)
          document.getElementById('search_form').setAttribute("value", "");
        }

    });

});


// function that initiates the map and searchBox in the index page
function initAutocomplete() {
  var map = new google.maps.Map(document.getElementById('map'), {
    center: {lat: 37.790841, lng: -122.4034689},
    zoom: 12,
    mapTypeId: google.maps.MapTypeId.ROADMAP
  });

  // Create the search box and link it to the UI element.
  var input = document.getElementById('address-input');
  var searchBox = new google.maps.places.SearchBox(input);
  map.controls[google.maps.ControlPosition.TOP_LEFT].push(input);

  // Bias the SearchBox results towards current map's viewport.
  map.addListener('bounds_changed', function() {
    searchBox.setBounds(map.getBounds());
  });

  var markers = [];
  // Listen for the event fired when the user selects a prediction and retrieve
  // more details for that place.
  searchBox.addListener('places_changed', function() {
    
    // get the object from the Places API upon user adding the address
    var places = searchBox.getPlaces();
    fillForm(places);
    
    if (places.length == 0) {
      return;
    }

    // Clear out the old markers.
    markers.forEach(function(marker) {
      marker.setMap(null);
    });
    markers = [];

    // For each place, get the icon, name and location.
    var bounds = new google.maps.LatLngBounds();
    places.forEach(function(place) {
      var icon = {
        url: place.icon,
        size: new google.maps.Size(71, 71),
        origin: new google.maps.Point(0, 0),
        anchor: new google.maps.Point(17, 34),
        scaledSize: new google.maps.Size(25, 25)
      };

      // Create a marker for each place.
      markers.push(new google.maps.Marker({
        map: map,
        icon: icon,
        title: place.name,
        position: place.geometry.location
      }));

      if (place.geometry.viewport) {
        // Only geocodes have viewport.
        bounds.union(place.geometry.viewport);
      } else {
        bounds.extend(place.geometry.location);
      }
    });
    map.fitBounds(bounds);
  });
}

// auto-fills the form from the object returned in the searchBox to include it in the form input
function fillForm (places) {
  search_address = places[0].formatted_address;
  document.getElementById('formatted_address').setAttribute("value", search_address);
}