class CreateGnlookupRegions < ActiveRecord::Migration
  def change
    create_table :gnlookup_regions do |t|
      t.string :iso
      t.string :name
      t.integer :country_id

      t.timestamps
    end
  end
end
