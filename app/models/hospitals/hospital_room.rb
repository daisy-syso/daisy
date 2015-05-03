class Hospitals::HospitalRoom < ActiveRecord::Base
  belongs_to :parent, class_name: 'HospitalRoom', foreign_key: 'parent_id'
  has_many :subroom, class_name: 'HospitalRoom', foreign_key: 'parent_id'


  

  class << self

  	def parent_menu
			where("parent_id is NULL").map do |room|
			{
				title: room.name,
				id: room.id
			}
		end
	end
  	

    include Filterable

    define_nested_filter_method :filters do
      self.all
    end
  end

end
