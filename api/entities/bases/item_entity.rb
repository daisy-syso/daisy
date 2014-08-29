module Bases
  class ItemEntity < ApplicationEntity
    expose :id, :name, :image_url

    with_options if: { detail: true } do
      expose :star, :reviews_count
    end

  end
end