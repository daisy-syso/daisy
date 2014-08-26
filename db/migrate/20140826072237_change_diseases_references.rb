class ChangeDiseasesReferences < ActiveRecord::Migration
  def change
    change_table :diseases do |t|
      t.remove :drug_type_id
      t.references :disease_type
    end

    change_table :drugs do |t|
      t.references :disease, index: true
    end
  end
end
