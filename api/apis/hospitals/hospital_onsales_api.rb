class Hospitals::HospitalOnsalesAPI < ApplicationAPI
	
	params do
        requires :id, type: Integer
    end

	get :thumb do
		hospital_onsale = Hospitals::HospitalOnsale.where(id:params[:id]).first
		thumb_old = hospital_onsale.thumb || 0
	    hospital_onsale.update(thumb: thumb_old+=1)
		p hospital_onsale
		return {data: hospital_onsale}
	end

	namespace :hospital_onsales do
		show! Hospitals::HospitalOnsale
	end
end 