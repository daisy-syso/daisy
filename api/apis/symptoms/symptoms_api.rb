class Symptoms::SymptomsAPI < ApplicationAPI
  format :json

  namespace :symptoms do 
    
    params do
      optional :page, type: Integer, desc: 'page'
      optional :per_page, type: Integer, desc: 'per_page'
    end
    get '/' do
      symptoms = Symptoms::Symptom.all.page(params[:page]).per(params[:per_page])

      results = []

      symptoms.each do |s|
        tmp = {
          id: s.id,
          name: s.name
        }
        results << tmp
      end

      {symptoms: results} 
    end

    params do
      optional :id, type: Integer, desc: 'ID'
    end
    get '/:id' do
      symptom = Symptoms::Symptom.find(params[:id])

      symptom_result = {
        id: symptom.id,
        name: symptom.name,
        xgjc: symptom.xgjc,
        xgzz: symptom.xgzz,
        xgyp: symptom.xgyp,
        xgjb: symptom.xgjb
      }

      symptom_details = Symptoms::SymptomDetail.where(detail_id: symptom.detail_id)

      symptom_detail_results = []

      symptom_details.each do |sd|
        tmp = {
          title: sd.title,
          detail: sd.detail,
          image_url: sd.image_url
        }
        symptom_detail_results << tmp
      end

      {
        symptoms: {
          symptom: symptom_result,
          details: symptom_detail_results
        }
      }

    end
  end
end
