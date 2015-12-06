class CreateIncidents < ActiveRecord::Migration
  def change
    create_table :incidents do |t|
      t.string :title
      t.text :content
      t.string :image_url
      t.string :author

      t.integer :e_drugstore_id

      t.timestamps null: false
    end

    add_index :incidents, :e_drugstore_id
  end
end
