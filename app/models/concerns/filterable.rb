module Filterable
  extend ActiveSupport::Concern

  included do
    include Cacheable

    def generate_filter record, key = nil
      Hash.new.tap do |ret|
        ret[:title] = record.name
        ret[:params] = { key => record.id } if key
      end
    end

    def generate_filters records, key = nil
      records.map do |record|
        generate_filter record, key
      end
    end

    def collect_nested_filter records, key, parent_id = nil
      return unless records[parent_id]
      records[parent_id].map do |record|
        generate_filter(record, key).tap do |ret|
          children = collect_nested_filter(records, key, record.id)
          ret[:children] = children if children
        end
      end
    end

    def prepend_filter_all filters, key
      filters.unshift(title: "全部", params: { key => nil })
    end

  end


  module ClassMethods
    def define_filter_method method, key, all = true, &block
      define_method method do
        generate_filters(class_eval(&block), key).tap do |ret|
          prepend_filter_all ret, key if all
        end
      end

      define_cached_methods method
    end

    def define_nested_filter_method method, key, all = true, &block
      define_method method do
        records = class_eval(&block).group_by(&:parent_id)
        collect_nested_filter(records, key).tap do |ret|
          prepend_filter_all ret, key if all
        end
      end

      define_cached_methods method
    end

    def generate_form_filters
      define_method :generate_filter do |record, key = nil|
        Hash.new.tap do |ret|
          ret[:title] = record.name
          ret[:id] = record.id
        end
      end
    end
  end
end