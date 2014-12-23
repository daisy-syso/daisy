class SetHospitalType < ActiveRecord::Migration
  def change
  	Hospitals::Hospital.where(is_foreign: true).each do |hospital|
  		type = Hospitals::HospitalType.find(7)
  		if !hospital.hospital_type_ids.include?(7)
  			hospital.hospital_types << type
  			hospital.save
  			p "hospital_id:#{hospital.id}"
  		end
  	end
  end
end
