module Localizable
  extend ActiveSupport::Concern

  included do
    # %w(lat lng geohash).each do |column|
    #   raise "column `#{column}` not found in table `#{table_name}`" unless attribute_names.include? column
    # end

    scope :nearest, -> (lat, lng) {
      dlat = (arel_table[:lat] - lat).to_sql
      # dlat = ((arel_table[:lat] - lat)*110.54).to_sql
      dlng = (arel_table[:lng] - lng).to_sql
      # dlng = ((arel_table[:lng] - lng)*111.32).to_sql
      where.not(lng: nil, lat: nil)
        .order("(#{dlat} * #{dlat} + #{dlng} * #{dlng}) ASC")
    }

    validates_each :address do |record, attr, value|
      if record.address.present? and record.address_changed?
        begin
          unless record.update_location
            errors.add(:address, :invalid)
          end
        rescue Exception => e
          errors.add(:base, e.message)
        end
      end
    end
  end

  def update_location
    bmap_geocoding_url = "http://api.map.baidu.com/geocoder/v2/?ak=E5072c8281660dfc534548f8fda2be11&output=json&address=#{address}"
    result = JSON.parse(RestClient.get(URI::encode(bmap_geocoding_url)))
    logger.info("  Requested BMap API #{bmap_geocoding_url}")
    logger.info("  Result: #{result['result'] rescue result}")
    if result['status'] == 0 and result['result'] and result['result'].any?
      self.lng, self.lat = result['result']['location']['lng'], 
        result['result']['location']['lat']
      update_geohash
    end
  end

  def update_geohash
    self.geohash = Geohash.encode(lng, lat)
  end
end