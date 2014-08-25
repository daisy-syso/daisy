class CreateDiseases < ActiveRecord::Migration
  def change
    create_table :diseases do |t|
      t.string :name
      t.text   :etiology
      t.text   :symptoms
      t.text   :examination
      t.text   :treatment
      t.text   :prevention
      t.text   :diet
      t.text   :desc

      t.references :drug_type, index: true

      t.timestamps
    end
  end
end
