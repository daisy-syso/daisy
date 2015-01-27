class Examinations::MedicalInstitution < ActiveRecord::Base
	belongs_to :hospital
	
	class << self
    include Filterable

    define_nested_filter_method :filters do
      self.all
    end
  end
end