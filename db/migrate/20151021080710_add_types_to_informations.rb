class AddTypesToInformations < ActiveRecord::Migration
  def change
  	add_column :informations, :types, :integer, default: 0
  end
end
