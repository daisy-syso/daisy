class EDrug < ActiveRecord::Base
  belongs_to :editor
  belongs_to :e_drugstore
end
