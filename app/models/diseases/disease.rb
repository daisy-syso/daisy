class Diseases::Disease < ActiveRecord::Base
  belongs_to :disease_type
  has_and_belongs_to_many :drugs, class_name: "Drugs::Drug"
  has_and_belongs_to_many :doctors, class_name: "Hospitals::Doctor"
  has_and_belongs_to_many :hospitals, class_name: "Hospitals::Hospital"
  has_and_belongs_to_many :symptoms, class_name: "Diseases::Symptom"
  has_and_belongs_to_many :hospital_rooms, class_name: "Hospitals::HospitalRoom"
  has_and_belongs_to_many :common_diseases, class_name: "Diseases::CommonDisease", :join_table => :disease_commons, :association_foreign_key => :common_id

  scope :disease_type, -> (type) { type ? where(disease_type: type) : all }

  scope :symptom, -> (symptom) {
    symptom ? joins(:symptoms)
      .where{diseases_symptoms.symptom_id == symptom}
      .distinct : all
  }

  scope :hospital_room, -> (hospital_room) {
    hospital_room ? joins(:hospital_rooms)
      .where{diseases_hospital_rooms.hospital_room_id == hospital_room}
      .distinct : all
  }

  scope :common_disease, -> (common_disease) {
    common_disease ? joins(:common_diseases)
      .where{disease_commons.common_id == common_disease}
      .distinct : all
  }

  scope :query, -> (query) {
    query.present? ? where{name.like("%#{query}%")} : all
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
