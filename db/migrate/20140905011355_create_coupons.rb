class CreateCoupons < ActiveRecord::Migration
  def change
    create_table :coupons do |t|
      t.references :item, index: true, polymorphic: true

      t.timestamps
    end
  end
end
