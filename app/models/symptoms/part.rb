class Symptoms::Part < ActiveRecord::Base

	has_many :symptoms, class_name: "Symptoms::Symptom"

	class << self
		include Filterable

		def filters
		  self.all.group_by do |record|
		    record.name
		  end.sort.map do |alphabet, records|
		    Hash.new.tap do |ret|
		      ret[:title] = alphabet
		    end
		  end
		end

		define_cached_methods :filters
	end
  
end
