class Diseases::Disease < ActiveRecord::Base
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
  
  # belongs_to :disease_type
  has_and_belongs_to_many :drugs, class_name: "Drugs::Drug"
  has_and_belongs_to_many :doctors, class_name: "Hospitals::Doctor"
  has_and_belongs_to_many :hospitals, class_name: "Hospitals::Hospital"
  has_and_belongs_to_many :symptoms, class_name: "Diseases::Symptom"
  has_and_belongs_to_many :hospital_rooms, class_name: "Hospitals::HospitalRoom"
  has_and_belongs_to_many :common_diseases, class_name: "Diseases::CommonDisease", :join_table => :disease_commons, :association_foreign_key => :common_id
  has_and_belongs_to_many :disease_types, class_name: "Diseases::DiseaseType" , :join_table => :diseases_types , :association_foreign_key => :disease_types_id
  has_many :disease_details, class_name: "Diseases::DiseaseDetail", :foreign_key => "parent_id"
  # scope :disease_type, -> (type) { type ? where(disease_type: type) : all }

  scope :symptom, -> (symptom) {
    symptom ? joins(:symptoms)
      .where{diseases_symptoms.symptom_id == symptom}
      .distinct : all
  }

  scope :hospital_room, -> (hospital_room) {

    if hospital_room 
      @hospital_room = Hospitals::HospitalRoom.where(id: hospital_room).first
      if @hospital_room.parent_id.blank?
        subroom_ids = @hospital_room.subroom.ids
        Diseases::Disease.joins(:hospital_rooms)
        .where(hospital_rooms: {id: subroom_ids})
        .distinct
      else
        joins(:hospital_rooms)
        .where{diseases_hospital_rooms.hospital_room_id == hospital_room}
      end
    else 
      all
    end
  }

  scope :common_disease, -> (common_disease) {
    common_disease ? joins(:common_diseases)
      .where{disease_commons.common_id == common_disease}
      .distinct : all
  }

  scope :disease_type, -> (disease_type) {
    disease_type ? joins(:disease_types)
      .where{diseases_types.disease_types_id == disease_type}
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
                  wildcard: {
                    name: "*#{query}*"
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
  
  scope :drug_query, -> (query) {
    query.present? ? joins(:drugs)
      .where{drugs.name.like("%#{query}%")}
      .distinct : all
  }

  scope :doctor_query, -> (query) {
    query.present? ? joins(:doctors)
      .where{doctors.name.like("%#{query}%")}
      .distinct : all
  }

  scope :hospital_query, -> (query) {
    query.present? ? joins(:hospitals)
      .where{hospitals.name.like("%#{query}%")}
      .distinct : all
  }

  scope :alphabet, -> (alphabet) { 
    alphabet ? where{name_initials.like("#{alphabet}%")} : all 
  }

  scope :menu_list, -> (hospital_room) {
    Diseases::Disease.hospital_room(hospital_room).map do |diseases|
      {
        name: diseases.name,
        url: "#/detail/diseases/diseases/#{diseases.id}"
      }
    end
  }

  scope :disease_id, ->(id) {
    id.present? ? where(id: id) : all
  }

  class << self
    include Filterable

    def collect_nested_filter records, parent_id = nil
      return unless records[parent_id]
      records[parent_id].map do |record|
        generate_filter(record).tap do |ret|
          children = self.collect_nested_filter(records, record.id)
          ret[:children] = children || 
            generate_filters(record.diseases)
        end
      end
    end

    def filters
      records = Diseases::DiseaseType.includes(:diseases).all.group_by(&:parent_id)
      prepend_filter_all collect_nested_filter(records)
    end

    define_cached_methods :filters
  end

end
