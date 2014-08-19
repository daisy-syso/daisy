class Hospitals::Examination < ActiveRecord::Base
  belongs_to :examination_type
  belongs_to :city
end
