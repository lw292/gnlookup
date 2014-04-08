module Gnlookup
  class Country < ActiveRecord::Base
    attr_accessible :iso, :iso_n, :iso3, :iso3_n, :name, :name_n
    has_many :regions
  end
end
