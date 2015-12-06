class CreateFeedbacks < ActiveRecord::Migration
  def change
    create_table :feedbacks do |t|
      t.string :content

      t.integer :e_drugstore_id

      t.timestamps null: false
    end

    add_index :incidents, :e_drugstore_id
  end
end
