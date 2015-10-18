class CreateEDrugstores < ActiveRecord::Migration
  def change
    create_table :e_drugstores do |t|
      t.string :name
      t.string :address
      t.string :telephone
      t.string :image_url
      t.float :lng
      t.float :lat
      t.integer :city_id
      t.integer :county_id
      t.integer :editor_id
      t.string :business_license

      t.timestamps
    end
    
    add_index :e_drugstores, :name
    add_index :e_drugstores, :editor_id
    add_index :e_drugstores, :city_id
    add_index :e_drugstores, :county_id
  end
end
