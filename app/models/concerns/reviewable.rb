module Reviewable
  extend ActiveSupport::Concern

  included do
    p attribute_names
    # p 22*"22"
    # %w(reviews_count star).each do |column|
    #   raise "column `#{column}` not found in table `#{table_name}`" unless attribute_names.include? column
    # end

    has_many :reviews, as: :item, class_name: 'UserInfos::Review'
  end


end