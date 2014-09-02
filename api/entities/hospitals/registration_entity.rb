class Hospitals::RegistrationEntity < Bases::PlaceEntity

  expose :link do |object, options|
    object.url
  end

end
