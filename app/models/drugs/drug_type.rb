class Drugs::DrugType < ActiveRecord::Base
  belongs_to :parent, class_name: 'DrugType', foreign_key: 'parent_id'
  has_many :children, class_name: 'DrugType', foreign_key: 'parent_id'
  has_many :drugs

  class << self
    include Cacheable

    def filters
      drug_types = self.all.to_a
      drug_types_by_parent = proc do |parent_id|
        drug_types.select do |drug_type|
          drug_type.parent_id == parent_id
        end
      end

      collect_filter = proc do |parent_id|
        drug_types_by_parent.call(parent_id).map do |drug_type|
          children = collect_filter.call(drug_type.id)
          Hash.new.tap do |ret|
            ret[:title] = drug_type.name
            ret[:params] = { drug_type: drug_type.id }
            ret[:children] = children if children.any?
          end
        end
      end

      collect_filter.call(nil)
    end

    define_cached_methods :filters
  end

end
