class Examinations::Examination < ActiveRecord::Base
  belongs_to :city, class_name: "Categories::City"
  belongs_to :examination_type
  belongs_to :hospital, class_name: "Hospitals::Hospital"

  scope :city, -> (city) { where(city: city) }
  scope :examination_type, -> (type) { 
    type ? where(examination_type_id: type) : all 
  }
  scope :examination_parent_type, -> (type) { 
    type ? where(examination_type_parent_id: type) : all 
  }
  scope :hospital, -> (type) { 
    type ? where(hospital_id: type) : all 
  }

  scope :price, -> (to, from = 0) {
    to ? where(price: from..to) : where{price > from}
  }

  scope :hospital_query, -> (query) {
    query.present? ? where{hospital_name.like("%#{query}%")} : all
  }

  scope :applicable_query, -> (query) {
    query.present? ? where{applicable.like("%#{query}%")} : all
  }

  # "template": "examinations/examinations",
  #           "id": 1,
  #           "name": "美年大健康北京酒仙桥分院标间C套餐（男）",
  def self.demand_attrs
    {
      only: [:id, :name, :feature, :image_url],
      methods: [:ori_price, :sale_price, :template]
    }
  end

  def template
    "examinations/examinations"
  end
  include Reviewable
  
  alias_attribute :sale_price, :price
  def ori_price
    (sale_price || 0) + (save_price || 0)
  end
  
end
