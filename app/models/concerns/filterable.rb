module Filterable
  extend ActiveSupport::Concern

  included do
    include Cacheable

    def generate_filter record, key = nil
      Hash.new.tap do |ret|
        ret[:id] = record.id if key
        ret[:title] = record.name
      end
    end

    def generate_filters records, key = nil, all = nil
      records.map do |record|
        generate_filter record, key
      end.tap do |ret|
        prepend_filter_all ret, key, all if key && all
      end
    end

    def collect_nested_filter records, key, all, parent_id = nil
      return unless records[parent_id]
      records[parent_id].map do |record|
        generate_filter(record, key).tap do |ret|
          children = collect_nested_filter(records, key, nil, record.id)
          ret[:children] = children if children
        end
      end.tap do |ret|
        prepend_filter_all ret, key, all if all
      end
    end

    def prepend_filter_all filters, key = nil, all = {}
      filter = { title: "全部", parent: true }
      filter.merge!(id: nil) if key
      filter.merge!(all)
      filters.unshift(filter)
    end

  end


  module ClassMethods
    def define_filter_method method, key, all = {}, &block
      define_method method do |*args|
        generate_filters(class_exec(*args, &block), key, all)
      end

      # define_cached_methods method
    end

    def define_nested_filter_method method, key, all = {}, &block
      define_method method do |*args|
        records = class_exec(*args, &block).group_by(&:parent_id)
        collect_nested_filter(records, key, all)
      end

      # define_cached_methods method
    end

    def generate_form_filters
      define_method :generate_filter do |record, key = nil|
        Hash.new.tap do |ret|
          ret[:id] = record.id
          ret[:title] = record.name
        end
      end
    end
  end
end