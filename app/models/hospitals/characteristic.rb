class Hospitals::Characteristic< ActiveRecord::Base
  has_and_belongs_to_many :hospitals, join_table: 'characteristic_hospitals', class_name: 'Hospitals::Hospital'

  # belongs_to :hospital_room
  # has_and_belongs_to_many :diseases, class_name: "Diseases::Disease"


  # include Reviewable
  # scope :hospital_count, -> {
  # 	hospital.joins(:characteristics)
  #     .where{characteristic_hospitals.characteristic_id == id}
  #     .distinct.count
  # }

  scope :order_by_abc, -> (a) {
    order(name_initials: :asc)
  }
  def hospital_count
  	hospitals.distinct.count
  end

  # def self.hospital_count
  	
  # end
end
