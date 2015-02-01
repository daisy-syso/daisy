class Diseases::CommonDisease < ActiveRecord::Base
	has_and_belongs_to_many :diseases, class_name: "Diseases::Disease", join_table: 'disease_commons', :foreign_key => :common_id #:through => :disease_commons, :association_foreign_key => :common_id
	class << self
    include Filterable

    def filters
    	self.all.order(:name_initials).map do |common| 
    		Hash.new.tap do |ret|
    			ret[:title] = common.name
    			ret[:id] = common.id
    		end
    	end
    end

    # define_cached_methods :filters
  end
end
