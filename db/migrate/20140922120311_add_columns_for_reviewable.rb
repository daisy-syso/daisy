class AddColumnsForReviewable < ActiveRecord::Migration
  def change
    %w(drugs drugstores nursing_rooms examinations doctors hospitals 
      confinement_centers maternal_halls shaping_items).each do |table|
      change_table table do |t|
        t.float   :star, :float, default: 5.0 rescue nil
        t.index   :star rescue nil
        t.integer :reviews_count, default: 0 rescue nil
        t.index   :reviews_count rescue nil
        t.timestamps rescue nil
      end
    end

  end
end
