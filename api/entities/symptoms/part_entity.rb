class Symptoms::PartEntity < ApplicationEntity
  
  expose :id, :name

  expose :symptoms, using: Symptoms::SymptomEntity

end
