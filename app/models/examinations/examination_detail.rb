class Examinations::ExaminationDetail < ActiveRecord::Base

  belongs_to :examinations, class_name: 'Examinations::Examination'

end
