class InformationComment < ActiveRecord::Base
  belongs_to :information, class_name: "Informations::Information"
end
