class Hospitals::Doctor < ActiveRecord::Base
  belongs_to :hospital
  belongs_to :hospital_room
end
