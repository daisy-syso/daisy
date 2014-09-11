class AddLocationInfos < ActiveRecord::Migration
  def change
    change_table :drugstores do |t|
      t.string :geohash
      t.index  :geohash
      t.float  :lng, limit: 53
      t.float  :lat, limit: 53
    end
    change_table :hospitals do |t|
      t.string :geohash
      t.index  :geohash
      t.float  :lng, limit: 53
      t.float  :lat, limit: 53
    end
    change_table :nursing_rooms do |t|
      t.string :geohash
      t.index  :geohash
      t.float  :lng, limit: 53
      t.float  :lat, limit: 53
    end
  end
end
