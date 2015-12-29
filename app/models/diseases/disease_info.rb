class Diseases::DiseaseInfo < ActiveRecord::Base
  self.table_name = "disease_infos"
  
  belongs_to :disease_info_type, class_name: "Diseases::DiseaseInfoType"
  belongs_to :information, class_name: "Informations::Information"
end