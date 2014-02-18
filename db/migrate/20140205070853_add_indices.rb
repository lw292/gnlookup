class AddIndices < ActiveRecord::Migration
  def change
    add_index :gnlookup_cities, :name
    add_index :gnlookup_cities, :name_ascii
    add_index :gnlookup_cities, :region_id
    add_index :gnlookup_regions, :iso
    add_index :gnlookup_regions, :name
    add_index :gnlookup_regions, :country_id
    add_index :gnlookup_countries, :iso
    add_index :gnlookup_countries, :iso3
    add_index :gnlookup_countries, :name
  end
end
