class UserInfos::PriceNotification < ActiveRecord::Base
  belongs_to :account
  belongs_to :item, polymorphic: true

  validates_presence_of :price
end
