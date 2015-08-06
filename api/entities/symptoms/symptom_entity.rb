class Symptoms::SymptomEntity < ApplicationEntity
  
  expose :id, :name

  with_options if: { detail: true } do
  	%w(xgjc xgzz xgyp xgjb).each do |xg|
	  	expose xg.to_sym do |symptom, options|
		  	symptom.send(xg.to_sym).nil? ? [] : symptom.send(xg.to_sym).split('、')
		end
	end
  end

end
