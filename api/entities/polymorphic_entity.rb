class PolymorphicEntity

  extend GrapeHelper

  def self.represent collection, options
    collection.map do |record|
      entity_class = get_entity_class record
      entity_class.represent record, hospital_onsales_no_type_id: true
    end
  end

end