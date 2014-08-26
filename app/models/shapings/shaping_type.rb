class Shapings::ShapingType < ActiveRecord::Base
  belongs_to :parent, class_name: 'ShapingType', foreign_key: 'parent_id'
  has_many :children, class_name: 'ShapingType', foreign_key: 'parent_id'

  class << self
    include Cacheable

    def filters
      shaping_types = self.all.to_a
      shaping_types_by_parent = proc do |parent_id|
        shaping_types.select do |shaping_type|
          shaping_type.parent_id == parent_id
        end
      end

      collect_filter = proc do |parent_id|
        shaping_types_by_parent.call(parent_id).map do |shaping_type|
          children = collect_filter.call(shaping_type.id)
          Hash.new.tap do |ret|
            ret[:title] = shaping_type.name
            ret[:params] = { shaping_type: shaping_type.id }
            ret[:children] = children if children.any?
          end
        end
      end

      collect_filter.call(nil)
    end

    define_cached_methods :filters
  end

end
