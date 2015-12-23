class CreatePreciseQueries < ActiveRecord::Migration
  def change
    create_table :precise_queries do |t|
      t.string :title
      t.string :link
      t.string :icon

      t.timestamps null: false
    end
  end
end
