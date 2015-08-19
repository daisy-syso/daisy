class Privileges::HospitalsAPI < ApplicationAPI

	namespace :hospitals do
		namespace :hospital_types do
			get do
				hospital_types = Hospitals::HospitalType.where(parent_id: [nil, '']) 
				present :data, hospital_types, with: Hospitals::HospitalTypeEntity, privileges: true
			end 

		end
	end

end