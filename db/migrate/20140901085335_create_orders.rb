class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.references :account
      t.references :item, index: true, polymorphic: true

      t.integer :quantity
      t.float  :price
      t.float  :discount

      t.string  :trade_no
      t.string  :provider
      
      t.string  :state

      t.string  :logistics_type
      t.string  :logistics_name
      t.float   :logistics_fee
      t.string  :logistics_payment
      t.string  :transport_type
      
      t.string  :receive_name
      t.text    :receive_address
      t.string  :receive_zip
      t.string  :receive_mobile

      t.timestamps
    end
  end
end
