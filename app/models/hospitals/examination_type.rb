class Hospitals::ExaminationType < ActiveRecord::Base
  belongs_to :parent, class_name: 'ExaminationType', foreign_key: 'parent_id'
  has_many :children, class_name: 'ExaminationType', foreign_key: 'parent_id'
  has_many :examinations

  class << self
    include Cacheable

    def filters
      examination_types = self.all.to_a
      examination_types_by_parent = proc do |parent_id|
        examination_types.select do |examination_type|
          examination_type.parent_id == parent_id
        end
      end

      collect_filter = proc do |parent_id|
        examination_types_by_parent.call(parent_id).map do |examination_type|
          children = collect_filter.call(examination_type.id)
          Hash.new.tap do |ret|
            ret[:title] = examination_type.name
            ret[:params] = { examination_type: examination_type.id }
            ret[:children] = children if children.any?
          end
        end
      end

      collect_filter.call(nil)
    end

    define_cached_methods :filters
  end

end
