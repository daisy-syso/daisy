class AddColumnsForReviewable < ActiveRecord::Migration
  def change
    %w(drugs drugstores nursing_rooms examinations doctors hospitals 
      confinement_centers maternal_halls shaping_items).each do |table|
      change_table table do |t|
        t.float   :star, default: 0.0
        t.index   :star
        t.integer :reviews_count, default: 0
        t.index   :reviews_count
        t.timestamps
      end
    end

  end
end
