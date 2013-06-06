require 'digest/md5'

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :name, :initials
  # attr_accessible :title, :body

  validates :name, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true
  validates :initials, presence: true, uniqueness: true

  has_many :messages
  has_many :recipients
  
  def gravatar_hash
    Digest::MD5.hexdigest(self.email)
  end
end
