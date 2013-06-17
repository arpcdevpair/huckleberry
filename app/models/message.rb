class Message < ActiveRecord::Base
  attr_accessible :text
  has_many :senders
  has_many :recipients
  has_many :channelMessages

  has_many :message_senders, through: :senders, source: :user
  has_many :message_recipients, through: :recipients, source: :user
  has_many :channels, through: :channelMessages

  validate :sender_may_not_be_recipient
  validates :message_recipients, :presence => true

  def sender_may_not_be_recipient
    errors[:senders] << I18n.t('errors.messages.model.message.includes_recipients') if
        ( message_recipients & message_senders ).present?
  end
end
