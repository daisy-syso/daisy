class VideoCategory < ActiveRecord::Base
  has_many :videos
end
