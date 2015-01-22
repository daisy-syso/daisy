class Hospitals::PolyclinicChargeEntity < ApplicationEntity

  expose :id, :name, :url
  
  expose :template do |object, options|
    "link"
  end

  expose :name_show do |object, options|
     object.name+"医疗价格表"
  end

end
