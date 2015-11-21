class CreateHamburgers < ActiveRecord::Migration
  def change
    create_table :hamburgers do |t|
      t.string :title
      t.string :name
      t.string :url
      t.string :image_url

      t.timestamps
    end
  end
end
