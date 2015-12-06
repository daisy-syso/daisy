class Incident < ActiveRecord::Base
  mount_uploader :image_url, PictureUploader
  
  belongs_to :e_drugstore
end
