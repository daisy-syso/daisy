class UserInfos::Review < ActiveRecord::Base
  belongs_to :account
  belongs_to :item, polymorphic: true
  belongs_to :order

  validates_inclusion_of :star, in: 1..5, message: :blank
  validates_presence_of :desc

  after_save do
    item.star = item.reviews.average(:star) || 5.0
    item.reviews_count = item.reviews.count
    item.save
  end

end
