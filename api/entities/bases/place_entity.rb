module Bases
  class PlaceEntity < ApplicationEntity
    expose :id, :name, :image_url, :lat, :lng

    with_options if: { detail: true } do
      expose :address, :star, :reviews_count
    end

  end
end