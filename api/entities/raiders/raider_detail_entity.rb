class Raiders::RaiderDetailEntity < Bases::ItemEntity

  expose :name, :details
  
  expose :template do |object, options|
    "link"
  end

  expose :url do |object, options|
	"#/detail/raiders/raider_details/#{object.id}"  	
  end
  

end
