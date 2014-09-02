class Account < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :token_authenticatable

  devise :omniauthable, :omniauth_providers => [:weibo]

  validates_presence_of :username
  validates_uniqueness_of :username

  has_many :favorites, class_name: "UserInfos::Favorite"
  has_many :price_notifications, class_name: "UserInfos::PriceNotification"

  def favorite_items
    self.favorites.includes(:item).map(&:item)
  end

  include Exclamationable
  def add_favorite item
    self.favorites.new(item: item)
  end

  def add_price_notification item, price
    self.price_notifications.new(item: item, price: price)
  end
  define_exclamation_and_methods :add_favorite, :add_price_notification
end
