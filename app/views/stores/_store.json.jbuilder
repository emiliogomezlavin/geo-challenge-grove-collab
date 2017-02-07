json.extract! store, :id, :store_name, :location, :address, :city, :state, :zip_code, :latitude, :longitude, :county, :created_at, :updated_at
json.url store_url(store, format: :json)