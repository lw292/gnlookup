class CreateGnlookupZipcodes< ActiveRecord::Migration
  def change
    create_table :gnlookup_zipcodes do |t|
      t.integer :city_id
      t.string :country_iso
      t.string :country_iso_n
      t.string :zipcode
      t.string :zipcode_n
      t.string :lat
      t.string :lng

      t.timestamps
    end
  end
end
