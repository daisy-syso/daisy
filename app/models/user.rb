class User < ActiveRecord::Base
  validates :account, uniqueness: true
end
