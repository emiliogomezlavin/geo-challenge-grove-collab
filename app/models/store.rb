class Store < ActiveRecord::Base

	geocoded_by :location
 	after_validation :geocode #fetches the coordinates

end
