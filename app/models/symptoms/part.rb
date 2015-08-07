class Symptoms::Part < ActiveRecord::Base

	has_many :symptoms, class_name: "Symptoms::Symptom"
  
end
