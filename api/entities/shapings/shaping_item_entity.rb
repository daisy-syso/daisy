class Shapings::ShapingItemEntity < Bases::ItemEntity

  expose :image_url, :price_scope, :target
  
  with_options if: { detail: true } do
  end
  
end