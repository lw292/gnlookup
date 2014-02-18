module Gnlookup
  class City < ActiveRecord::Base
    attr_accessible :geoname_id, :lat, :lng, :name, :name_ascii, :region_id
    belongs_to :region
  
    def country
      self.region.country
    end
  end
end
