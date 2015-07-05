class AddStarsToReviews < ActiveRecord::Migration
  def change
    add_column :reviews, :environment, :integer
    add_column :reviews, :service, :integer
    add_column :reviews, :charge, :integer
    add_column :reviews, :technique, :integer
  end
end
