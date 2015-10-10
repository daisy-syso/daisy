class AddReadCountToInformations < ActiveRecord::Migration
  def change
  	add_column :informations, :read_count, :integer, default: 0
  end
end
