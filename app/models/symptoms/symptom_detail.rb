class Symptoms::SymptomDetail < ActiveRecord::Base
  belongs_to :symptom, class_name: "Symptoms::Symptom"
end