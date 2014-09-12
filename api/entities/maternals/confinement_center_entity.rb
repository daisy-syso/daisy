class Maternals::ConfinementCenterEntity < ApplicationEntity
  
  expose :id, :name, :lat, :lng, :star

  with_options if: { detail: true } do
    expose :address, :reviews_count
  end

end