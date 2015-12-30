class Diseases::DiseaseInfoType < ActiveRecord::Base
  belongs_to :parent, class_name: 'DiseaseInfoType', foreign_key: 'parent_id'
  has_many :children, class_name: 'DiseaseInfoType', foreign_key: 'parent_id'

  belongs_to :disease, class_name: "Diseases::Disease"

  belongs_to :follow, class_name: "UserInfos::Follow"

  has_many :disease_infos, class_name: "Diseases::DiseaseInfo"
  has_many :informations, class_name: "Informations::Information", through: :disease_infos
end