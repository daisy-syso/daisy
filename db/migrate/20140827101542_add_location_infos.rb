class AddLocationInfos < ActiveRecord::Migration
  def change
    change_table :drugstores do |t|
      t.string :geohash
      t.index  :geohash
      t.float  :lat
      t.float  :lng
    end
    change_table :hospitals do |t|
      t.string :geohash
      t.index  :geohash
      t.float  :lat
      t.float  :lng
    end
    change_table :nursing_rooms do |t|
      t.string :geohash
      t.index  :geohash
      t.float  :lat
      t.float  :lng
    end
  end
end
