class Diseases::DiseaseType < ActiveRecord::Base
  belongs_to :parent, class_name: 'DiseaseType', foreign_key: 'parent_id'
  has_many :children, class_name: 'DiseaseType', foreign_key: 'parent_id'
  has_many :diseases

  class << self
    include Cacheable

    def filters
      disease_types = self.all.to_a
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
            ret[:params] = { disease_type: disease_type.id }
            ret[:children] = children if children.any?
          end
        end
      end

      collect_filter.call(nil)
    end

    define_cached_methods :filters
  end

end
