class AddLocationInfos < ActiveRecord::Migration
  def change
    change_table :drugstores do |t|
      t.string :geohash
      t.index  :geohash
      t.double :lng
      t.double :lat
    end
    change_table :hospitals do |t|
      t.string :geohash
      t.index  :geohash
      t.double :lng
      t.double :lat
    end
    change_table :nursing_rooms do |t|
      t.string :geohash
      t.index  :geohash
      t.double :lng
      t.double :lat
    end
  end
end
