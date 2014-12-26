class AddPraiseToHospitalOnsale < ActiveRecord::Migration
  def change
  	add_column :hospital_onsales, :thumb, :integer
  end
end
