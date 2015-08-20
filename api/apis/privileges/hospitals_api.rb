class Privileges::HospitalsAPI < ApplicationAPI

	namespace :hospitals do
		namespace :hospital_types do
			get do
				hospital_types = Hospitals::HospitalType.where(parent_id: [nil, '']) 
				present :data, hospital_types, with: Hospitals::HospitalTypeEntity, privileges: true
			end 

			get "/:id/hospital_charges" do 
				hospital_charges = Hospitals::HospitalCharge.where(hospital_type_id: params[:id])
				present :data, hospital_charges
			end

			get "/hospital_charges/:id/hospital_onsales" do 
				hospital_onsales = Hospitals::HospitalOnsale.where(hospital_charge_id: params[:id])
				present :data, hospital_onsales, with: Hospitals::HospitalOnsaleEntity
			end

			get "hospital_charges/hospital_onsales/:id" do
				hospital_onsale = Hospitals::HospitalOnsale.where(id: params[:id]).first
				present :data, hospital_onsale, with: Hospitals::HospitalOnsaleEntity
			end

		end
	end

end