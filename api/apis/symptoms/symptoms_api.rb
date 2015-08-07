class Symptoms::SymptomsAPI < ApplicationAPI
  format :json

  namespace :symptoms do

    index! Symptoms::Part,
      title: '症状查询'

    show! Symptoms::Symptom

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
