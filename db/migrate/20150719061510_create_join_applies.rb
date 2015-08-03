class CreateJoinApplies < ActiveRecord::Migration
  def change
    create_table :join_applies do |t|
      t.references :target, index: true, polymorphic: true
      t.string :email, index: true
      t.string :contact_user
      t.string :contact_phone
      t.text :admin_comment
      t.integer :status, default: 0

      t.timestamps
    end

    change_table :hospitals do |t|
      t.integer :status, default: 1
    end
    change_table :doctors do |t|
      t.integer :status, default: 1
    end
    change_table :drugstores do |t|
      t.integer :status, default: 1
    end
    change_table :manufactories do |t|
      t.integer :status, default: 1
    end
    change_table :nursing_rooms do |t|
      t.integer :status, default: 1
    end
    change_table :confinement_centers do |t|
      t.integer :status, default: 1
    end
    change_table :maternal_halls do |t|
      t.integer :status, default: 1
    end
    change_table :insurances do |t|
      t.integer :status, default: 1
    end
  end
end
