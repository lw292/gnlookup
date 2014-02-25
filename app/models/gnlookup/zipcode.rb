module Gnlookup
  class Zipcode < ActiveRecord::Base
    attr_accessible :country_iso, :lat, :lng, :zipcode, :place_name, :admin_name, :admin_code, :city_id
    belongs_to :city
  end
end
