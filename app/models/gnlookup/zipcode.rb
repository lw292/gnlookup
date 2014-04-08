module Gnlookup
  class Zipcode < ActiveRecord::Base
    attr_accessible :country_iso, :country_iso_n, :lat, :lng, :zipcode, :zipcode_n, :place_name, :admin_name, :admin_code, :city_id
    belongs_to :city
  end
end
