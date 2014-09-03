class Examinations::Examination < ActiveRecord::Base
  belongs_to :city, class_name: "Categories::City"
  belongs_to :examination_type

  scope :city, -> (city) { where(city: city) }
  scope :examination_type, -> (type) { type ? where(examination_type: type) : all }

  include Reviewable
  
  alias_attribute :sale_price, :price
  def ori_price
    sale_price + save_price
  end
  
end
