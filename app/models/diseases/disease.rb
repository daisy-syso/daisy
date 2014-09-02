class Diseases::Disease < ActiveRecord::Base
  belongs_to :disease_type

  scope :disease_type, -> (type) { type ? where(disease_type: type) : all }

  class << self
    include Cacheable

    def filters
      disease_types = Diseases::DiseaseType.includes(:diseases).all.to_a
      disease_types_by_parent = proc do |parent_id|
        disease_types.select do |disease_type|
          disease_type.parent_id == parent_id
        end
      end

      collect_filter = proc do |parent_id|
        disease_types_by_parent.call(parent_id).map do |disease_type|
          children = collect_filter.call(disease_type.id)
          Hash.new.tap do |ret|
            ret[:title] = disease_type.name
            if children.any?
              ret[:children] = children
            else
              ret[:children] = disease_type.diseases.map do |disease|
                Hash.new.tap do |ret|
                  ret[:title] = disease.name
                  ret[:params] = { disease: disease.id }
                end
              end
            end
          end
        end
      end
      
      collect_filter.call(nil)
    end

    define_cached_methods :filters
  end

end
