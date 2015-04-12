class Informations::HealthInformation < ActiveRecord::Base
	belongs_to :health_information_type, class_name: "Informations::HealthInformationType", foreign_key: 'type_id'
	
	scope :picture_infors, -> (n=4) { where( flag: 1).order(id: :desc).first(n) }
	scope :title_infors, -> (n=4) { where( flag: 2).order(id: :desc).first(n) }
end
