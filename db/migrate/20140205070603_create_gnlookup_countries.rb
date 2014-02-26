class CreateGnlookupCountries < ActiveRecord::Migration
  def change
    create_table :gnlookup_countries do |t|
      t.string :iso
      t.string :iso_n
      t.string :iso3
      t.string :iso3_n
      t.string :name
      t.string :name_n

      t.timestamps
    end
  end
end
