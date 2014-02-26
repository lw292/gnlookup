class AddIndices < ActiveRecord::Migration
  def change
    add_index :gnlookup_cities, :name_n
    add_index :gnlookup_cities, :region_id
    add_index :gnlookup_regions, :iso_n
    add_index :gnlookup_regions, :name_n
    add_index :gnlookup_regions, :country_id
    add_index :gnlookup_countries, :iso_n
    add_index :gnlookup_countries, :iso3_n
    add_index :gnlookup_countries, :name_n
    add_index :gnlookup_zipcodes, :zipcode_n
    add_index :gnlookup_zipcodes, :city_id
    add_index :gnlookup_zipcodes, :country_iso_n
  end
end
