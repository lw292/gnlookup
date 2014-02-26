class CreateGnlookupRegions < ActiveRecord::Migration
  def change
    create_table :gnlookup_regions do |t|
      t.string :iso
      t.string :iso_n
      t.string :name
      t.string :name_n
      t.integer :country_id

      t.timestamps
    end
  end
end
