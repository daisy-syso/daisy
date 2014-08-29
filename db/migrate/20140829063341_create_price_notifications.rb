class CreatePriceNotifications < ActiveRecord::Migration
  def change
    create_table :price_notifications do |t|
      t.references :account, index: true
      t.references :item, index: true, polymorphic: true
      
      t.float :price

      t.timestamps
    end
  end
end
