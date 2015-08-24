class Hospitals::HospitalCharge < ActiveRecord::Base
  belongs_to :hospital_type
  has_many :hospital_onsales, class_name: "Hospitals::HospitalOnsale"
  scope :hospital_parent_type, -> (type) { 
    type ? where(hospital_type_parent_id: type) : all 
  }

  scope :hospital_type, -> (type) { 
    type ? where(hospital_type_id: type) : all 
  }

  class << self
    include Filterable

    def generate_filter record
      Hash.new.tap do |ret|
        ret[:title] = record.name
        ret[:id] = record.id
      end
    end

    define_filter_method :filters do
      self.all
    end

  end

end
