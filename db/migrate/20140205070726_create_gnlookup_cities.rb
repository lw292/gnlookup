class CreateGnlookupCities < ActiveRecord::Migration
  def change
    create_table :gnlookup_cities do |t|
      t.integer :geoname_id
      t.integer :region_id
      t.string :name
      t.string :name_ascii
      t.string :lat
      t.string :lng

      t.timestamps
    end
  end
end
