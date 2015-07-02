class Drugs::DrugmanufactoryEntity < ApplicationEntity

  expose :id, :name

  expose :manufactories, using: Drugs::ManufactoryEntity
end