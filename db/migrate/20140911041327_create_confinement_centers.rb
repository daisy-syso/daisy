class CreateConfinementCenters < ActiveRecord::Migration
  def change
    create_table :confinement_centers do |t|
      t.references :city, index: true

      t.string :name
      t.string :address
      t.string :telephone
      t.string :url
      t.float :lng, limit: 53
      t.float :lat, limit: 53
      t.string :geohash

      t.timestamps
    end
  end
end
