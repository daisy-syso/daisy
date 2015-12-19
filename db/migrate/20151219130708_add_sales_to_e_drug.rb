class AddSalesToEDrug < ActiveRecord::Migration
  def change
    add_column :e_drugs, :sales, :integer, default: 0

    add_index :e_drugs, :sales
  end
end
