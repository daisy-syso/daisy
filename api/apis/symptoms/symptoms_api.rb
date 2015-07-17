class Symptoms::SymptomsAPI < ApplicationAPI
  format :json

  namespace :symptoms do 
    
    params do
    end
    get '/' do
      parts = Symptoms::Part.all

      results = []
      parts.each do |part|

        symptoms = Symptoms::Symptom.where(part_id: part.id)

        symptoms_arr = []

        symptoms.each do |s|
          tmp = {
            id: s.id,
            name: s.name
          }
          symptoms_arr << tmp
        end

        tt = {
          part_name: part.name,
          symptoms: symptoms_arr
        }

        results << tt
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
