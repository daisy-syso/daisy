class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.references :account, index: true
      t.references :item,    index: true, polymorphic: true
      t.references :order,   index: true
      
      t.integer :star
      t.text :desc

      t.timestamps
    end
  end
end
