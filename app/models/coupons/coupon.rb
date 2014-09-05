class Coupons::Coupon < ActiveRecord::Base
  belongs_to :item, polymorphic: true

end
