class AddIsTopToInformations < ActiveRecord::Migration
  def change
  	add_column :informations, :is_top, :boolean, default: false
  end
end
