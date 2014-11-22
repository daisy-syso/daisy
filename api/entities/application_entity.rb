class ApplicationEntity < Grape::Entity

  expose :template do |object, options|
    object.class.name.tableize
  end

end
