class Store < ActiveRecord::Base

	geocoded_by :location
 	after_validation :geocode #fetches the coordinates


	def self.find_closest_store (store_coordinates)
		@stores = Store.all
		min_dist = 1000000
		store_id = nil
		@stores.each do |store|
				distance = Geocoder::Calculations.distance_between(store_coordinates, [store["latitude"],store["longitude"]])
				if distance < min_dist
					store_id = store["id"]
					min_dist = distance
				end
		end
		return store_id
	end
end
