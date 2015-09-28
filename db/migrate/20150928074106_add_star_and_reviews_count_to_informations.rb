class AddStarAndReviewsCountToInformations < ActiveRecord::Migration
  def change
  	add_column :informations, :star, :float
  	add_column :informations, :reviews_count, :integer
  end
end
