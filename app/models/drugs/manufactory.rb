class Drugs::Manufactory < ActiveRecord::Base

  settings index: {number_of_shards: 5} do
    mappings do
      indexes :name, boost:  100
      indexes :name_initials, boost: 50
    end
  end
  
  has_and_belongs_to_many :drugs, class_name: "Drugs::Drug"

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
