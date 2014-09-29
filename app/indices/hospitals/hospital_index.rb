ThinkingSphinx::Index.define :"hospitals/hospital", :with => :active_record do
  indexes name
  indexes environment_desc, service_desc, skill_desc, equipment_desc

  has created_at, updated_at

  has "RADIANS(lat)", as: :latitude,  type: :float
  has "RADIANS(lng)", as: :longitude, type: :float
  
end