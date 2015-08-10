class AddStarAndReviewsCountToExaminations < ActiveRecord::Migration
  def change
  	add_column :examinations_new, :star, :integer
  	add_column :examinations_new, :reviews_count, :integer
  end
end