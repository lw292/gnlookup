# This rake task was inspired by and partly adapted from the work of 
# Resister Software: https://github.com/chendo/geonames

namespace :gnlookup do
  desc "Import geonames data from the db/geonames directory."
  task :import => :environment do
    # Data files
    COUNTRIES = "db/geonames/countryInfo.txt"
    REGIONS = "db/geonames/admin1CodesASCII.txt"
    US_ZIPCODES = "db/geonames/US.txt"
    # Allow user-specified file for cities. Default to cities5000.txt
    args = ENV['CITIES'].split(',') if !ENV['CITIES'].blank?
    if !args.blank? && !args[0].blank?
      CITIES = "db/geonames/"+args[0]+".txt"
    else
      CITIES = "db/geonames/cities5000.txt"
    end

    # Proceed only if all three files exist.
    if File.exists?(COUNTRIES) && File.exists?(REGIONS) && File.exist?(US_ZIPCODES) && File.exists?(CITIES)
      # Empty data holder
      countries = {}

      # Countries
      puts "\nImporting countries ..."
      f = File.open(COUNTRIES)
      count = 0
      # Getting the first row of data
      row = f.gets
      while (row.match(/^#/) or row.match(/^iso/i))
        row = f.gets
      end
      # Process each row of data
      while (row)
        row = row.split(/\t/)
        # Does the country exist already in the db?
        c = Gnlookup::Country.find(:first, :conditions => {:iso => row[0], :iso3 => row[1], :name => row[4]})
        # If not, create it.
        if c.nil?
          c = Gnlookup::Country.create(:iso => row[0], :iso3 => row[1], :name => row[4])
        end
        # Save the country's id to the data holder
        # Example: countries["CN"]: {"id" => 89}
        unless c.nil?
          countries[row[0]] = {"id" => c.id}
        end
        # Read the next row
        row = f.gets
        # Increment the counter
        count += 1
        # Display the progress
        if count%100 == 0
          print "#"
          $stdout.flush
        end
      end
      puts "\nThere are #{Gnlookup::Country.count()} countries in the system."

      # Regions
      puts "\nImporting regions ..."
      f = File.open(REGIONS)
      count = 0
      # Process each row of data
      while (row = f.gets)
        row = row.split(/\t/)
        # Split the first column into country code and region index
        # Example: CN.56
        (country, region_index) = row[0].split('.')
        country_id = countries[country]["id"]
        # Only proceed if such a country exists in the db
        if !country_id.nil?
          # 00 is not a valid region index
          if region_index != '00'
            # Does the region exist already in the db?
            r = Gnlookup::Region.find(:first, :conditions => {:name => row[1], :iso => region_index, :country_id => country_id})
            # If not, create it.
            if r.nil?
              r = Gnlookup::Region.create(:name => row[1], :iso => region_index, :country_id => country_id)
            end
            # Save region's id to the data holder
            # Example: countries["CN"]: {"id" => 89, "23" => 123, "56" => 567, ...}
            unless r.nil?
              countries[country][region_index] = r.id
            end
          end
        end
        # Increment the counter
        count += 1
        # Display the progress
        if count%100 == 0
          print "#"
          $stdout.flush
        end
      end
      puts "\nThere are #{Gnlookup::Region.count()} regions in the system."

      # Cities
      puts "\nImporting cities ..."
      f = File.open(CITIES)
      count = 0
      # Process each row of data
      while (row = f.gets)
        row = row.split(/\t/)
        region_id = countries[row[8]][row[10]]
        # Proceed only if such a region exists in the db
        if !region_id.nil?
          # Does the city exist already in the db?
          c = Gnlookup::City.find(:first, :conditions => {:name => row[1], :region_id => region_id})
          # If not, create it.
          if c.nil?
            Gnlookup::City.create(:name => row[1], :region_id => region_id, :name_ascii => row[2], :lat => row[4], :lng => row[5])
          end
          # Increment the counter
          count += 1
          # Display the progress
          if count%100 == 0
            print "#"
            $stdout.flush
          end
          if count%10000 == 0
            puts " " + count.to_s + " cities imported.\n"
          end
        end
      end
      puts "\nThere are now #{Gnlookup::City.count()} cities in the system."
      
      # US ZIPCODES
      puts "\nImporting US Zipcodes ..."
      f = File.open(US_ZIPCODES)
      count = 0
      # Process each row of data
      while (row = f.gets)
        row = row.split(/\t/)
        region_id = countries[row[0]][row[4]]
        z = Gnlookup::Zipcode.find(:first, :conditions => {:country_iso => row[0], :zipcode => row[1], :place_name => row[2], :admin_name => row[3], :admin_code => row[4]})
        if z.nil?
          c = Gnlookup::City.find(:first, :conditions => {:name => row[2], :region_id => region_id})
          if c.nil?
            c = Gnlookup::City.create(:name => row[2], :region_id => region_id, :name_ascii => row[2], :lat => row[9], :lng => row[10])
          end
          Gnlookup::Zipcode.create(:country_iso => row[0], :zipcode => row[1], :place_name => row[2], :admin_name => row[3], :admin_code => row[4], :lat => row[9], :lng => row[10], :city_id => c.id)
        end
        # Increment the counter
        count += 1
        # Display the progress
        if count%100 == 0
          print "#"
          $stdout.flush
        end
        if count%10000 == 0
          puts " " + count.to_s + " US zipcodes imported.\n"
        end
      end
      puts "\nThere are now #{Gnlookup::Zipcode.count()} US zipcodes in the system."
    else
      puts "\nAt least one data file is missing. Please check."
    end
  end
end
