class Examinations::Examination < ActiveRecord::Base

  self.table_name = "examinations_new"

  include Reviewable

  belongs_to :city, class_name: "Categories::City"
  belongs_to :hospital, class_name: "Hospitals::Hospital"
  belongs_to :examination_type_one, class_name: 'Examinations::ExaminationType'
  belongs_to :examination_type_two, class_name: 'Examinations::ExaminationType'
  has_many :examination_details, class_name: 'Examinations::ExaminationDetail', foreign_key: 'parent_id'

  scope :city, -> (city) { where(city: city) }
  scope :hospital, -> (type) { 
    type ? where(hospital_id: type) : all 
  }
  scope :price, -> (to, from = 0) {
    to ? where(price: from..to) : where{price > from}
  }
  scope :hospital_query, -> (query) {
    query.present? ? where{hospital_name.like("%#{query}%")} : all
  }

  def self.demand_attrs
    {
      only: [:id, :name, :image_url],
      methods: [:ori_price, :sale_price, :template]
    }
  end
  
  def examination_type
    [examination_type_one, examination_type_two]
  end

  def template
    "examinations/examinations"
  end
  
end
