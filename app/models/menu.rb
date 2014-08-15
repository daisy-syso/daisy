class Menu < ActiveRecord::Base
  belongs_to :parent, class_name: 'Menu', foreign_key: 'parent_id'
  validates :title, :name,  presence: true

  def children
    Menu.where(parent_id: id).order(:seq)
  end

  def has_children?
    children.empty? ? false : true
  end

  def self.top_menus
    Menu.where(parent_id: nil).order(:seq) 
  end
end
