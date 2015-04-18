class Raiders::RaiderDetail < ActiveRecord::Base
  belongs_to :raider, class_name: 'Raiders::Raider', foreign_key: 'parent_id'
 
  scope :raider_id, -> (raider_id) { where(parent_id: raider_id)}
end
