class CreateInformationComments < ActiveRecord::Migration
  def change
    create_table :information_comments do |t|
      t.text :content
      t.integer :information_id

      t.timestamps null: false
    end
  end
end
