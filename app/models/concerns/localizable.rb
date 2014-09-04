module Localizable
  extend ActiveSupport::Concern

  included do
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