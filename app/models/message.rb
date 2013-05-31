class Message < ActiveRecord::Base
  attr_accessible :text
    belongs_to :sender, class_name: 'User'
    validates :sender, presence: { message: 'The message requires a sender' }
end
