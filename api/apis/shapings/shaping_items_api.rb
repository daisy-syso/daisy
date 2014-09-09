class Shapings::ShapingItemsAPI < Grape::API
  extend ResourcesHelper

  namespace :shaping_items do
    show! Shapings::ShapingItem
  end

end
