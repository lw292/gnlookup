module Gnlookup
  class Region < ActiveRecord::Base
    attr_accessible :country_id, :iso, :iso_n, :name, :name_n
    belongs_to :country
    has_many :cities
  end
end
