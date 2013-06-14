class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :name, :initials, :approved
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
end
