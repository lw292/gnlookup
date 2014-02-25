class CreateGnlookupCountries < ActiveRecord::Migration
  def change
    create_table :gnlookup_countries do |t|
      t.string :iso
      t.string :iso3
      t.string :name

      t.timestamps
    end
  end
end
