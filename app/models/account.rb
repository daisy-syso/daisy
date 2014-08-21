class Account < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :token_authenticatable

  validates_presence_of :username
  validates_uniqueness_of :username

  has_many :favorites

  def favorite_items
    self.favorites.includes(:item).map(&:item)
  end

  def add_favorite_item item
    self.favorites.push Favorite.new(item: item)
  end
end
