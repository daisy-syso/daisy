class UserInfos::Review < ActiveRecord::Base
  belongs_to :account
  belongs_to :item, polymorphic: true
  belongs_to :order

  validates_inclusion_of :star, in: 1..5, message: :blank
  validates_presence_of :desc

end
