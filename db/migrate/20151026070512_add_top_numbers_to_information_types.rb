class AddTopNumbersToInformationTypes < ActiveRecord::Migration
  def change
  	add_column :information_type, :top_number, :integer, default: 1
  end
end
