class CreateMaternalHalls < ActiveRecord::Migration
  def change
    create_table :maternal_halls do |t|
      t.references :city, index: true

      t.string :name
      t.string :address
      t.string :telephone
      t.float  :lng, limit: 53
      t.float  :lat, limit: 53
      t.string :geohash

      t.timestamps
    end
  end
end
