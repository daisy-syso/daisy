class Hospitals::PolyclinicCharge < ActiveRecord::Base
  belongs_to :province, class_name: "Categories::Province"

  scope :city, -> (city) { all }
  scope :province, -> (province) { where(province: province) }

end
