class AddDrugTpyeIdToEDrug < ActiveRecord::Migration
  def change
    add_column :e_drugs, :drug_type_id, :integer
    add_column :e_drugs, :drug_type_id2, :integer
    add_column :e_drugs, :drug_type_id3, :integer
  end

  # add_index :e_drugs, :drug_type_id
end
