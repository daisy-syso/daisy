class Drugs::Drug < ActiveRecord::Base
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  validates_presence_of :name, :manufactory
  validates_uniqueness_of [:name, :manufactory] 

  settings index: {number_of_shards: 5} do
    mappings do
      indexes :name, type: 'string', index: :not_analyzed, analyzer: :keyword
      indexes :name_initials, boost: 50
    end
  end

  def as_indexed_json(options={})
    as_json(only: ['name','name_initials'])
  end
  
  # belongs_to :drug_type
  # has_and_belongs_to_many :drug_types, class_name: "Drugs::DrugType", join_table: 'diseases_drugs', association_foreign_key: "disease_id"
  has_and_belongs_to_many :diseases, class_name: "Diseases::Disease"
  has_and_belongs_to_many :hospital_rooms, class_name: "Hospitals::HospitalRoom"
  has_and_belongs_to_many :manufactories, class_name: "Drugs::Manufactory", join_table: 'manufactory_drugs'
  has_and_belongs_to_many :drugstores, class_name: "Drugs::Drugstore", join_table: 'drug_manufactory_stores'
  has_many :drug_manufactory_stores, class_name: "Drugs::DrugManufactoryStore"
  has_many :manufactory_drugs, class_name: "Drugs::ManufactoryDrug"
  has_many :diseases_drugs, class_name: 'Drugs::DiseasesDrug'
  has_many :drug_details, class_name: 'Drugs::DrugDetail'

  belongs_to :editors

  scope :drug_type, -> (type) { type ? where(drug_type: type) : all }
  
  scope :disease, -> (type) { 
    if type 
      disease_id = Drugs::DrugType.where(id: type).first.disease_id
      Drugs::Drug.joins(:diseases_drugs)
        .where(diseases_drugs: { disease_id: disease_id})
        .distinct 
    else 
      all 
    end
  }

  scope :drug, -> (t) {
    where(name: t)
  }

  scope :hospital_room, -> (hospital_room) {
    hospital_room ? joins(:hospital_rooms)
      .where{drugs_hospital_rooms.hospital_room_id == hospital_room}
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
                  match_phrase_prefix: {
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
  
  scope :manufactory_query, -> (query) {
    query.present? ? where{manufactory.like("%#{query}%")} : all
  }
  
  scope :price, -> (to, from = 0) {
    to ? where(ori_price: from..to) : where{ori_price > from}
  }

  scope :alphabet, -> (alphabet) { 
    alphabet ? where{name_initials.like("#{alphabet}%")} : all 
  }

  # scope :manufactory, -> (type) { 
  #   type ? joins(:manufactories)
  #     .where(manufactory_drugs: { manufactory_id: type })
  #     .distinct : all 
  # }

  scope :manufactory_alph, -> (alph) {
    alph ? joins(:manufactories)
      .where("manufactories.name_initials like '%#{alph}%'")
       : all 
  }
  
  scope :extension, -> (b) {
    b ==1 ? order(extension: :desc) : order(id: :asc)
  }


  include Reviewable

end
