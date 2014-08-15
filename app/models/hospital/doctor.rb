class Hospital::Doctor < ActiveRecord::Base
  belongs_to :hospital
  belongs_to :hospital_room
end
