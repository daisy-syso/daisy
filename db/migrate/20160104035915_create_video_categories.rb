class CreateVideoCategories < ActiveRecord::Migration
  def change
    create_table :video_categories do |t|
      t.string :name
      t.integer :iqiyi_id

      t.timestamps null: false
    end
  end
end
