class CreateDiseaseTypes < ActiveRecord::Migration
  def change
    create_table :disease_types do |t|
      t.string     :name
      t.references :parent, index: true
    end
  end
end
