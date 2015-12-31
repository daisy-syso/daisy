class UserInfos::Follow < ActiveRecord::Base
  belongs_to :account

  has_one :disease_info_type, class_name: "Diseases::DiseaseInfoType"

  before_save do
    self.top_name = Diseases::DiseaseInfoType.find(Diseases::DiseaseInfoType.find(self.disease_info_type_id).parent_id).name
  end
end