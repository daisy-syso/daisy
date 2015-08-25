class AddStartToHospitalOnsale < ActiveRecord::Migration
  def change
  	add_column :hospital_onsales, :star, :integer
  	add_column :hospital_onsales, :reviews_count, :integer
  end
end
