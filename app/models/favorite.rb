class Favorite < ActiveRecord::Base
  belongs_to :account
  belongs_to :item, polymorphic: true

  validates_uniqueness_of :item_id, scope: :account_id

end
