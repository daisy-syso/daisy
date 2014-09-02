class UserInfos::Review < ActiveRecord::Base
  belongs_to :account
  belongs_to :item, polymorphic: true
  belongs_to :order
  
end
