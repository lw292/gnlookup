module Gnlookup
  class Country < ActiveRecord::Base
    attr_accessible :geoname_id, :iso, :iso3, :name
    has_many :regions
  end
end
