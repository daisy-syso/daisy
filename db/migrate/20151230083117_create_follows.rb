class CreateFollows < ActiveRecord::Migration
  def change
    create_table :follows do |t|
      t.integer :account_id
      t.integer :disease_info_type_id
      t.string :top_name

      t.timestamps null: false
    end
  end
end
