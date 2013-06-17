class Message < ActiveRecord::Base
  attr_accessible :text
  has_many :senders
  has_many :recipients
  has_many :channelMessages

  has_many :message_senders, through: :senders, source: :user
  has_many :message_recipients, through: :recipients, source: :user
  has_many :channels, through: :channelMessages

  validate :sender_may_not_be_recipient

  def sender_may_not_be_recipient
    errors[:message_senders] << I18n.t('sender_as_recipient') if
        ( message_recipients & message_senders ).present?
  end
end
