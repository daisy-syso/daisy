class Video < ActiveRecord::Base
  belongs_to :video_category

  validates :album_name, presence: true, uniqueness: true
end
