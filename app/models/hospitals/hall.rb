class Hospitals::Hall < ActiveRecord::Base
	has_many :hospital_onsales, class_name: "Hospitals::HospitalOnsale", foreign_key: 'hospital_id'

	scope :city, -> (city) { where(city_id: city) }
	scope :county, -> (county) { where(county: county) }	

	scope :order_by_url, -> (t = true) {
    # order(hospital_level_id: :desc).order(url: :desc)
  }
	scope :only_onsales, -> (hospital_type_id){
    @hospital_onsales = Hospitals::HospitalOnsale.joins(:hospital_charge).where(hospital_charge: { hospital_type_id: hospital_type_id })
    p @hospital_onsales
    hospital_ids = @hospital_onsales.map {|onsale| onsale.hospital_id}
    p hospital_ids
    Hospitals::Hall.where(id: hospital_ids)
  }
end