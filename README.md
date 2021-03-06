
![MacDown logo](http://theroadtodomestication.com/wp-content/uploads/2016/03/grove-collab-logo.png)

# Read Me    


Hello there! I’m **Emilio Gomez**, and this is my solution for the geo-challenge for Grove Collaborative.

Let me introduce my solution!

</br>


## How it works

This is a Ruby on Rails app that uses the Geocoder Gem to calculate the closest store to a given address. Additional features include that users can search for an address via Google Maps and upon finding the correct address, the application auto-fills the form so the user can find the closest store without having to worry about the format that the address is included



</br>


## Rationale

After some research on best practices of how to calculate distance between to addresses, I found that the most accurate way to do this is by using its coordinates. The Zip Code was my first approach since it's a simpler comparisson, however, there's a lot of edge cases to consider when comparing ZipCodes (e.g. if you have two addresses in the same ZipCode, if you have two adjacent ZipCodes with a store how do you define which store is actually closer, etc).

Once I definied my search would be made using the lat and lng, I found that one of the most common ways to calculate the distance between two coordinates on earth is the [Haversine formula](https://en.wikipedia.org/wiki/Haversine_formula). After more research on gems and libraries that help you calculate this formula, I decided to use the Geocoder gem for Ruby which provides a method to caculate the distance between two addresses and returning the distance as a float. 

The algorithm is based on a brute force solution that gets the store_array and iterates through the list of stores and keeping track of the smallest distance and then returning that store.

After having a working solution, I decided to add an adicional UX feature that allows the user to search for an address using a map from Google Maps and then recovering the address in a format that enables the search for the closest store.



## Refactoring and other solutions
-  My solution is not the most efficient but I wanted to comply with a 2 hour limit and this is the working solution I was able to deliver in that timeframe. However, with a bit more time I would have done some refactoring to improve the running time of the request. An idea I would implement next would be to search first using the ZipCode to find a block of ZipCodes from stores that are close by based on a +/- 100 number difference (ensuring to capture an area surrounding the ZipCode). And then running the Geocoder calculations of distance but only with the ZipCodes in this block of stores to significantly reduce the amount of server calls done to the Geocoder server. This would be a simple fix that would significantly improve the run time and it would also scale very weel if more stores were added to the DB. 
-  I decided to use Geocoder for simplicity of calculations but Google Maps API also provides a distance matrix that enables you to not only calculate distance but to return different driving methods and the time it would take you to cover such distance.
-  Another way of solving this problem could've been using a Heap data structure with a min/max lenght search. I decided to use available resources because of the time restriction but using this should definitely provide efficiencies in the running time complexity.

  
  
    
### Resources used
 
-  [Stackoverflow](http://stackoverflow.com/questions/12966638/how-to-calculate-the-distance-between-two-gps-coordinates-without-using-google-m)
-  [GeoKit gem](https://github.com/geokit/geokit)
-  [Geocoder gem](https://github.com/alexreisner/geocoder)
-  [Max-lenght-heap](http://jsperf.com/max-length-heap-test)
-  [ZipCodeAPI](https://www.zipcodeapi.com/)
-  [Google Maps API - Distance Matrix](https://developers.google.com/maps/documentation/distance-matrix/intro#DistanceMatrixRequests)