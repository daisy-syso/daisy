class PolymorphicEntity

  extend GrapeHelper

  def self.represent collection, options
    collection.map do |record|
      entity_class = get_entity_class record
      entity_class.represent record
    end
  end

end