class Drug::Drug < ActiveRecord::Base
  belongs_to :drug_type, class_name: 'DrugType'
end
