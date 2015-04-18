class Raiders::RaiderEntity < Bases::ItemEntity

  expose :name
  expose :template do |object, options|
    "link"
  end

  


end
