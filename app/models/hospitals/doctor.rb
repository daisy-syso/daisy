class Hospitals::Doctor < ActiveRecord::Base
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  settings index: {number_of_shards: 5} do
    mappings do
      indexes :name, type: 'string', index: :not_analyzed, analyzer: :keyword
      indexes :name_initials, boost: 50
    end
  end

  def as_indexed_json(options={})
    as_json(only: ['name','name_initials'])
  end
  
  belongs_to :hospital, class_name: "Hospitals::Hospital"
  belongs_to :hospital_room, class_name: "Hospitals::HospitalRoom"
  has_and_belongs_to_many :diseases, class_name: "Diseases::Disease"

  scope :city, -> (city) { 
    joins(:hospital)
      .where(hospitals: { city_id: city })
      .distinct 
  }
  scope :county, -> (county) { 
    joins(:hospital)
      .where(hospitals: { county_id: county })
      .distinct 
  }
  
  scope :hospital, -> (hospital) { where(hospital: hospital) }
  scope :hospital_room, -> (hospital_room) { where(hospital_room: hospital_room) }

  scope :disease, -> (disease) {
    disease ? joins(:diseases)
      .where{diseases_doctors.disease_id == disease}
      .distinct : all
  }

  # scope :query, -> (query) {
  #   query.present? ? where{name.like("%#{query}%")} : all
  # }

  scope :query, -> (query) {
    if query.present? 
      search(
        {
          query: {
            bool: {
              should:[
                {
                  match_phrase_prefix: {
                    name_initials: query
                  }
                },
                {
                  match: {
                    name: query
                  }
                }
              ]
            }
          }
        }
      )
    else
      all
    end
  }
  
  scope :hospital_query, -> (query) {
    query.present? ? joins(:hospitals)
      .where{hospitals.name.like("%#{query}%")}
      .distinct : all
  }

  scope :position_query, -> (query) {
    query.present? ? where{position.like("%#{query}%")} : all
  }

  scope :alphabet, -> (alphabet) { 
    alphabet ? where{name_initials.like("#{alphabet}%")} : all 
  }

  include Reviewable
  include JoinAppliable
end
