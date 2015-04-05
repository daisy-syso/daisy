class Drugs::Drug < ActiveRecord::Base
  belongs_to :drug_type
  has_and_belongs_to_many :diseases, class_name: "Diseases::Disease"
  has_and_belongs_to_many :hospital_rooms, class_name: "Hospitals::HospitalRoom"
  has_and_belongs_to_many :manufactories, class_name: "Drugs::Manufactory", join_table: 'manufactory_drugs'

  scope :drug_type, -> (type) { type ? where(drug_type: type) : all }
  
  scope :disease, -> (type) { 
    type ? joins(:diseases)
      .where(diseases_drugs: { disease_id: type })
      .distinct : all 
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
      where("name_initials LIKE ? 
        or name LIKE ? 
        or maufatory_initials LIKE ? 
        or maufatory LIKE ? ",
        "%#{query}%" ,
        "%#{query}%", 
        "%#{query}%",
        "%#{query}%"
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

  scope :manufactory, -> (type) { 
    type ? joins(:manufactories)
      .where(manufactory_drugs: { manufactory_id: type })
      .distinct : all 
  }
  
  include Reviewable

end
