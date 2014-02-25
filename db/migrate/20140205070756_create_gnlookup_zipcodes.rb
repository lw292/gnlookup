class CreateGnlookupZipcodes< ActiveRecord::Migration
  def change
    create_table :gnlookup_zipcodes do |t|
      t.integer :region_id
      t.string :country_iso
      t.string :zipcode
      t.string :place_name
      t.string :admin_name
      t.string :admin_code
      t.string :lat
      t.string :lng

      t.timestamps
    end
  end
end
