class AddFormattedAddressToStore < ActiveRecord::Migration
  def change
  	add_column :stores, :formatted_address, :string
  end
end
