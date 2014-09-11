class MaternalHall < ActiveRecord::Base
  belongs_to :city, class_name: "Categories::City"
end
