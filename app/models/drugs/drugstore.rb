class Drugs::Drugstore < ActiveRecord::Base
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  settings index: {number_of_shards: 5} do
    mappings do
      indexes :name, type: 'string', index: :not_analyzed, analyzer: :keyword
      indexes :name_initials, boost: 50
    end
  end

  belongs_to :editors

  validates_presence_of :name, :address, :telephone, :county_id, :city_id

  belongs_to :city, class_name: "Categories::City"
  belongs_to :county, class_name: "Categories::County"
  has_and_belongs_to_many :drugs, class_name: "Drugs::Drug", join_table: 'drug_manufactory_stores'
  has_many :drug_manufactory_stores, class_name: "Drugs::DrugManufactoryStore"
  
  scope :city, -> (city) { where(city: city) }
  scope :county, -> (county) { where(county: county) }
  
  scope :is_local_hot, -> (boolean = true) {
    boolean ? where(is_local_hot: true) : where.not(is_local_hot: true)
  }
  
  # scope :query, -> (query) {
  #   query.present? ? where{name.like("%#{query}%")} : all
  # }

  scope :query, -> (query) {
    if query.present? 
      where("name_initials LIKE ? 
        or name LIKE ? 
        or address LIKE ?",
        "%#{query}%" ,
        "%#{query}%", 
        "%#{query}%"
      ) 
    else
      all
    end
  }

  scope :extension, ->(b) {
    b ==1 ? order(extension: :desc) : order(id: :asc)
  }

  scope :alphabet, -> (alphabet) { 
    alphabet ? where{name_initials.like("#{alphabet}%")} : all 
  }
  include Reviewable
  include JoinAppliable

end
