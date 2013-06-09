class Message < ActiveRecord::Base
  attr_accessible :text, :recipient, :sender, :channelMessages
  has_many :senders
  has_many :recipients
  has_many :channelMessages
  
  def list_of_recipients
    recipients.map(&:user).map(&:name).join ", "
  end

  def list_of_senders
    senders.map(&:user).map(&:name).join ", "
  end
end
