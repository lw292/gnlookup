module Gnlookup
  class Zipcode < ActiveRecord::Base
    attr_accessible :country_iso, :lat, :lng, :zipcode, :place_name, :admin_name, :admin_code, :region_id
    belongs_to :region
  end
end
