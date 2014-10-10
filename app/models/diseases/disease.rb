class Diseases::Disease < ActiveRecord::Base
  belongs_to :disease_type

  has_and_belongs_to_many :drugs, class_name: "Drugs::Drug"
  has_and_belongs_to_many :doctors, class_name: "Hospitals::Doctor"
  has_and_belongs_to_many :hospitals, class_name: "Hospitals::Hospital"

  scope :disease_type, -> (type) { type ? where(disease_type: type) : all }

  class << self
    include Filterable

    def collect_nested_filter records, parent_id = nil
      return unless records[parent_id]
      records[parent_id].map do |record|
        generate_filter(record).tap do |ret|
          children = self.collect_nested_filter(records, record.id)
          ret[:children] = children || 
            generate_filters(record.diseases, :disease)
        end
      end
    end

    def filters
      records = Diseases::DiseaseType.includes(:diseases).all.group_by(&:parent_id)
      collect_nested_filter records
    end

    define_cached_methods :filters
  end

end
