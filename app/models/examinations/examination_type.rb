class Examinations::ExaminationType < ActiveRecord::Base
  
  has_many :examinations_one, class_name: 'Examinations::Examination', foreign_key: 'examination_type_one_id'
  has_many :examinations_two, class_name: 'Examinations::Examination', foreign_key: 'examination_type_two_id'
  has_one :examination_charge

  def self.generate_attrs
    select("id, name").where(parent_id: nil).map{|et| 
        {id: et.id,
         name: et.name,
         template: "examinations/examination_types", 
         url: "#/list/examinations/examinations?type=#{et.id}",
         child_types: self.select("id, name").where(parent_id: et.id).map{|o|
            {
              id: o.id,
              name: o.name,
              template: "examinations/examination_types", 
              url: "#/list/examinations/examinations?type=#{o.id}"
            }
         }
       }
    }
  end

  class << self
    include Filterable

    define_nested_filter_method :filters do
      self.all
    end
  end

end
