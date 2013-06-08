class Message < ActiveRecord::Base
  attr_accessible :text, :recipient, :sender
  has_many :senders
  has_many :recipients
  
  def list_of_recipients
    recipients.map(&:user).map(&:name).join ", "
  end

  def list_of_senders
    senders.map(&:user).map(&:name).join ", "
  end
end
