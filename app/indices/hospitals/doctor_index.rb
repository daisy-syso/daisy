ThinkingSphinx::Index.define :"hospitals/doctor", :with => :active_record do
  indexes name
  indexes desc

  has created_at, updated_at
  
end