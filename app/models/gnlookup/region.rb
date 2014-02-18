module Gnlookup
  class Region < ActiveRecord::Base
    attr_accessible :country_id, :iso, :name
    belongs_to :country
    has_many :cities
  end
end
