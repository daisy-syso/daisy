class NetInfos::FriendlyLinkType < ActiveRecord::Base
  has_many :friendly_links, class_name: 'FriendlyLink'
end
