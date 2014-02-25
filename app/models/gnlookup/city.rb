module Gnlookup
  class City < ActiveRecord::Base
    attr_accessible :lat, :lng, :name, :name_ascii, :region_id
    belongs_to :region
    has_many :zipcodes
  
    def country
      self.region.country
    end
  end
end
