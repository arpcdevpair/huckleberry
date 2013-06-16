class Message < ActiveRecord::Base
  attr_accessible :text
  has_many :senders
  has_many :recipients
  has_many :channelMessages

  has_many :message_senders, through: :recipients, source: :user
  has_many :message_recipients, through: :senders, source: :user
  has_many :channels, through: :channelMessages
end
