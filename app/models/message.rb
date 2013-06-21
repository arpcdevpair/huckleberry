class Message < ActiveRecord::Base
  attr_accessible :text
  has_many :senders
  has_many :recipients
  has_many :channelMessages

  has_many :message_senders, through: :senders, source: :user
  has_many :message_recipients, through: :recipients, source: :user
  has_many :channels, through: :channelMessages

  validates :text, presence: true
  validates :message_recipients, presence: true
  validates :message_senders, presence: true

  validate :sender_may_not_be_recipient
  validate :text_recipient_tags_map
  validate :text_sender_tags_map
  validate :text_has_non_tags

  def text_has_non_tags
    errors[:text] << 'must have content other than tags' if text.present? && non_tags.blank?
  end

  def sender_may_not_be_recipient
    errors[:senders] << I18n.t('errors.messages.model.message.includes_recipients') if
        ( message_recipients & message_senders ).present?
  end

  def text_recipient_tags_map
    recipient_tags.each do |initials|
      user = User.find_by_initials(initials)
      errors[:text] << "@#{initials} not mapped" unless user.present?
    end
  end

  def text_sender_tags_map
    sender_tags.each do |initials|
      user = User.find_by_initials(initials)
      errors[:text] << "#{initials}> not mapped" unless user.present?
    end
  end

  def words
    text.blank? ? [] : text.gsub(/[?,!]/, ' ').split
  end

  def non_tags
    words.reject {|word| word =~ Regexp.union(/([\w\.]+)>/, /@([\w\.]+)/, /#([\w\.]+)/) }
  end

  def sender_tags
    tags /([\w\.]+)>/
  end

  def recipient_tags
    tags /@([\w\.]+)/
  end

  # @param [Regexp] pattern
  def tags pattern
    tags = []
    return tags unless text.present?
    text.scan(pattern).map(&:first).map(&:downcase).uniq.each do |initials|
      tags << initials
    end
    tags
  end
end
