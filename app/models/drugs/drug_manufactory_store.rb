class Drugs::DrugManufactoryStore < ActiveRecord::Base
	has_and_belongs_to_many :drugs, class_name: "Drugs::Drug"
	has_and_belongs_to_many :drug_stores, class_name: "Drugs::Drugstore"
	has_and_belongs_to_many :manufactories, class_name: "Drugs::Manufactory"

  scope :alphabet, -> (alphabet) { 
    alphabet ? where{name_initials.like("#{alphabet}%")} : all 
  }
  class << self
    include Filterable

    # def define_nested_filter_method method, all = {}, &block
    #   define_method method do |*args|
    #     records = class_exec(*args, &block)
    #     collect_nested_filter(records, all)
    #   end

    #   define_cached_methods method
    # end

    # define_nested_filter_method :filters do
    #   self.all
    # end
    def filters
    	self.all
    end
  end
	

end

