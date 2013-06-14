require 'digest/md5'

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :name, :initials, :approved, :last_active_at
  # attr_accessible :title, :body

  validates :name, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true
  validates :initials, presence: true, uniqueness: { case_sensitive: false }
  #set_primary_key "initials"

  has_many :messages
  has_many :recipients
  has_many :senders
  def to_param
    initials
  end

  def gravatar_hash
    Digest::MD5.hexdigest(self.email)
  end
  
  def active_for_authentication
    super && approved?
  end
  
  def inactive_message 
    if !approved? 
      :not_approved 
    else 
      super # Use whatever other message 
    end 
  end
  
  def online?
    last_active_at > 10.minutes.ago if last_active_at
  end
end
