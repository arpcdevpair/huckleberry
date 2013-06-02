class Message < ActiveRecord::Base
  attr_accessible :text, :recipient, :sender
    belongs_to :sender, class_name: 'User'
    belongs_to :recipient, class_name: 'User'
    validates :sender, presence: { message: 'The message requires a sender' }
    validates :recipient, presence: { message: 'The message requires a recipient' }
end
