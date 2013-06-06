class Message < ActiveRecord::Base
  attr_accessible :text, :recipient, :sender
  belongs_to :sender, class_name: 'User'
  validates :sender, presence: { message: 'The message requires a sender' }
  has_many :recipients
  
  def list_of_recipients
    recipients.map(&:user).map(&:name).join ", "
  end
end
