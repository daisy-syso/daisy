class Hospitals::Characteristic< ActiveRecord::Base
  belongs_to :hospital
  # belongs_to :hospital_room
  # has_and_belongs_to_many :diseases, class_name: "Diseases::Disease"


  # include Reviewable

end
