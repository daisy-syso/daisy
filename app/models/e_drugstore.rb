class EDrugstore < ActiveRecord::Base
  mount_uploader :image_url, PictureUploader

  belongs_to :editor

  has_many :e_drugs, dependent: :destroy
  has_many :incidents, dependent: :destroy
  has_many :feedbacks, dependent: :destroy
end
