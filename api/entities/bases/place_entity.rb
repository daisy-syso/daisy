class Bases::PlaceEntity < ApplicationEntity
  
  expose :id, :name, :image_url, :lat, :lng, :star

  with_options if: { detail: true } do
    expose :address, :reviews_count
    expose :reviewable do |object, options|
      true
    end
  end

end
