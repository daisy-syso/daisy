class CreateEDrugs < ActiveRecord::Migration
  def change
    create_table :e_drugs do |t|
      t.string :name
      t.float :ori_price
      t.float :price
      t.string :manufactory
      t.string :introduction
      t.string :image_url
      t.string :brand
      t.string :code
      t.string :expiry_date
      t.string :spec
      
      t.integer :editor_id
      t.integer :e_drugstore_id

      t.timestamps
    end

    add_index :e_drugs, :name
    add_index :e_drugs, :editor_id
    add_index :e_drugs, :e_drugstore_id
  end
end
