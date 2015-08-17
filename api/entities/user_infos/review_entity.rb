class UserInfos::ReviewEntity < ApplicationEntity

	include GrapeHelper
  
	expose :id, :item_type, :star, :desc, :created_at, :environment, :service, :charge, :technique

  	expose :item do |instance, options|
  		"#{instance.item_type}Entity".constantize.represent instance.item, options
  	end

  	expose :account do |instance, options|
  		instance.account.username
  	end

end
