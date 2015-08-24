class Hospitals::HospitalType < ActiveRecord::Base
  has_and_belongs_to_many :hospitals, join_table: 'hospitals_types'
  has_many :hospital_types, class_name: 'HospitalType', foreign_key: 'parent_id'
  has_many :hospital_charges, class_name: "Hospitals::HospitalCharge"
  

  def hospital_charges
    return Hospitals::HospitalCharge.where(hospital_type_id: self.hospital_types.ids ) if self.parent_id.blank? 
    super
  end

  class << self
    include Filterable

    def generate_filter record
      Hash.new.tap do |ret|
        ret[:title] = record.name
        ret[:image_url] = record.image_url
        ret[:id] = record.id
      end
    end

    define_filter_method :filters do |args|
      args || self.all
    end

  end

end
