class UserInfos::Follow < ActiveRecord::Base
  belongs_to :account

  has_one :disease_info_type, class_name: "Diseases::DiseaseInfoType"

  before_save do
    sef.top_name = Diseases::DiseaseInfoType.find(self.parent_id).name
  end
end