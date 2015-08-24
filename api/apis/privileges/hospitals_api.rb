class Privileges::HospitalsAPI < ApplicationAPI

	namespace :hospitals do
		namespace :hospital_types do
			
			filters = {
					city: city_filters,
	        type: type_filters("团购优惠"),
	        charge: { title: "团购", class: Hospitals::HospitalCharge },
	        order_by: order_by_filters(Hospitals::Hospital),
	        form: form_filters,
	        need_order: form_switch_filters("无需预约"),
	        has_return: form_switch_filters("返现"),
	        template: form_radio_array_filters_new("andrology", "当前主题精选"),
	        price_scope: form_price_scope_filters([500, 1000, 5000, 10000, 20000])
				}
			hfilters = {}


			desc "医院类型"
			get do


				filters.each do |key, options|
	        filter = generate_filter key, options
	        if options[:titleize]
	          
	        elsif options[:append]
	          hfilters[options[:append]][:children] ||= []
	          hfilters[options[:append]][:children].push filter
	        else
	          hfilters[key] = filter
	        end
	      end
	      fts = hfilters.values if hfilters.any?
				
				present :filters, fts
				hospital_types = Hospitals::HospitalType.where(parent_id: [nil, '']) 
				present :data, hospital_types, with: Hospitals::HospitalTypeEntity, privileges: true
			end 

			desc "大类别下的所有优惠项目"
			get "/:id" do 
				filters.each do |key, options|
	        filter = generate_filter key, options
	        if options[:titleize]
	          
	        elsif options[:append]
	          hfilters[options[:append]][:children] ||= []
	          hfilters[options[:append]][:children].push filter
	        else
	          hfilters[key] = filter
	        end
	      end
      	fts = hfilters.values if hfilters.any?
				present :filters, fts
				hospital_charges = Hospitals::HospitalCharge.where(hospital_type_parent_id: params[:id])
				present :data, hospital_charges
			end


			desc "小类别下的所有优惠项目"
			get "/:id/hospital_charges" do 
				filters.each do |key, options|
	        filter = generate_filter key, options
	        if options[:titleize]
	          
	        elsif options[:append]
	          hfilters[options[:append]][:children] ||= []
	          hfilters[options[:append]][:children].push filter
	        else
	          hfilters[key] = filter
	        end
	      end
      	fts = hfilters.values if hfilters.any?
				present :filters, fts
				hospital_charges = Hospitals::HospitalCharge.where(hospital_type_id: params[:id])
				present :data, hospital_charges
			end

			desc "对应优惠项目的医院"
			get "/hospital_charges/:id/hospital_onsales" do 
				filters.each do |key, options|
	        filter = generate_filter key, options
	        if options[:titleize]
	          
	        elsif options[:append]
	          hfilters[options[:append]][:children] ||= []
	          hfilters[options[:append]][:children].push filter
	        else
	          hfilters[key] = filter
	        end
	      end
      	fts = hfilters.values if hfilters.any?
				present :filters, fts
				if params[:id] == "all"
					hospital_onsales = Hospitals::HospitalOnsale.page(params[:page]) 
				else
					hospital_onsales = Hospitals::HospitalOnsale.where(hospital_charge_id: params[:id]).page(params[:page])
				end
				present :data, hospital_onsales, with: Hospitals::HospitalOnsaleEntity
			end

			desc "某优惠医院的详情"
			get "hospital_charges/hospital_onsales/:id" do
				hospital_onsale = Hospitals::HospitalOnsale.where(id: params[:id]).first
				present :data, hospital_onsale, with: Hospitals::HospitalOnsaleEntity
			end

		end

		index! Hospitals::HospitalOnsale,
			title: "团购优惠",
      filters: { 
        type: type_filters("团购优惠"),
        hospital_type: hospital_type_filters,
        order_by: hospital_order_by_filters,
        form: form_filters,
        extension: { scope_only: true, default: 1, type: Integer},
        need_order: form_switch_filters("无需预约"),
        has_return: form_switch_filters("返现"),
        # template: form_radio_array_filters(%w(不限 (含淋巴结清扫和取活检) 耻骨上前列腺切除术 耻骨后前列腺切除术 经会阴前列腺切除术 前列腺囊肿切除术 前列腺脓肿切开术 经尿道前列腺电切术(激光法) 经尿道前列腺电切术(电切法) 经尿道前列腺电切术(汽化法) 经尿道前列腺气囊扩张术 经尿道前列腺支架置入术 前列腺摘除术),
          # "当前主题精选"),
        template: form_radio_array_filters_new("andrology", "当前主题精选"),
        price_scope: form_price_scope_filters([500, 1000, 5000, 10000, 20000])
      },
      includes: [:hospital]

	end

end