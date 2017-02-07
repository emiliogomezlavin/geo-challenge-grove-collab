require 'csv'

Store.destroy_all
 
csv_text = File.read(Rails.root.join('lib', 'seeds', 'store-locations.csv'))
csv = CSV.parse(csv_text, :headers => true, :encoding => 'ISO-8859-1')

csv.each do |row|
  t = Store.new
  t.store_name = row['Store Name']
  t.location = row['Store Location']
  t.address = row['Address']
  t.city = row['City']
  t.state = row['State']
  t.zip_code = row['Zip Code']
  t.latitude = row['Latitude']
  t.longitude = row['Longitude']
  t.county = row['County']
  t.save
  puts "#{t.address}, #{t.city} saved"
end

puts "There are now #{Store.count} rows in the transactions table"# This file should contain all the record creation needed to seed the database with its default values.
