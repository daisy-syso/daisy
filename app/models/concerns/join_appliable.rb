module JoinAppliable
  extend ActiveSupport::Concern

  included do
    # %w(status).each do |column|
    #   raise "column `#{column}` not found in table `#{table_name}`" unless attribute_names.include? column
    # end

    has_one :join_apply, as: :target, class_name: 'JoinApplies::JoinApply'
  end
end