class ChangeExaminationDetailsType < ActiveRecord::Migration
  def change
  	rename_column :examination_details, :type, :types
  end
end
