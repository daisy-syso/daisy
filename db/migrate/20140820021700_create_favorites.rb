class CreateFavorites < ActiveRecord::Migration
  def change
    create_table :favorites do |t|
      t.references :account, index: true
      t.references :item, index: true, polymorphic: true

      t.timestamps
    end
  end
end
