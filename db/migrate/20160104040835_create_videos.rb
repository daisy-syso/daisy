class CreateVideos < ActiveRecord::Migration
  def change
    create_table :videos do |t|
      t.string :album_name
      t.string :pic_url
      t.string :play_url
      t.integer :tv_id
      t.datetime :create_time
      t.integer :time_length
      t.string :sub_title
      t.string :html5_url
      t.string :html5_play_url
      t.integer :video_category_id

      t.timestamps null: false
    end
  end
end
