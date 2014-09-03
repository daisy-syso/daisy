class ApplicationEntity < Grape::Entity

  expose :type do |object, options|
    object.class.name.tableize
  end

end
