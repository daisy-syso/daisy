class Drugs::Manufactory < ActiveRecord::Base
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks
  include JoinAppliable

  settings index: {number_of_shards: 5} do
    mappings do
      indexes :name, type: 'string', index: :not_analyzed, analyzer: :keyword
      indexes :name_initials, boost: 50
    end
  end

  def as_indexed_json(options={})
    as_json(only: ['name','name_initials'])
  end
  
  has_and_belongs_to_many :drugs, class_name: "Drugs::Drug", join_table: 'manufactory_drugs'

  scope :alphabet, -> (alphabet) { 
    alphabet ? where{name_initials.like("#{alphabet}%")} : all 
  }

  scope :query, -> (query) {
    if query.present? 
      # where("name LIKE :query or name_initials LIKE :query or address LIKE :query ", query: "%#{query}%")
      search(
        {
          query: {
            bool: {
              should:[
                {
                  match_phrase_prefix: {
                    name_initials: query
                  }
                },
                {
                  match: {
                    name: query
                  }
                }
              ]
            }
          }
        }
      )
    else
      all
    end
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
