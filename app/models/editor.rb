class Editor < ActiveRecord::Base
  validates :email, presence: true, uniqueness: true, format: {with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }
  validates :password, presence: true, length: {minimum: 6}
  validates :username, presence: true

  # has_many :drugstores, class_name: "Drugs::Drugstore"
  # has_many :drugs, class_name: "Drugs::Drug"

  has_many :e_drugstores, dependent: :destroy
  has_many :e_drugs, dependent: :destroy

  include BCrypt

  rolify

  def password
    @password ||= Password.new(password_hash)
  end

  def password=(new_password)
    @password = Password.create(new_password)
    self.password_hash = @password
  end

  def role
    role = self.roles.first.try(:name) || 'other'
  end
end
