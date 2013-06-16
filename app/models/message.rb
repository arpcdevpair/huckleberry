class Message < ActiveRecord::Base
  attr_accessible :text, :recipient, :sender, :channelMessages
  has_many :senders
  has_many :recipients
  has_many :channelMessages

  has_many :sender_users, through: :recipients, source: :user
  has_many :recipient_users, through: :senders, source: :user

  def list_of_recipients
    recipients.map(&:user).map(&:name).join ", "
  end

  def list_of_senders
    senders.map(&:user).map(&:name).join ", "
  end
end
