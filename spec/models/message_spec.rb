require 'spec_helper'

describe Message do
  before do
    @message = Message.new

  end

  it 'must not have sender as recipient' do

    message = Message.new
    message.message_senders << users(:approved)
    message.message_recipients << users(:approved)
    message.should_not be_valid
    message.errors[:message_senders].should include I18n.t('sender_as_recipient')

    message = Message.new
    message.message_senders << users(:approved)
    message.message_recipients << users(:admin)
    message.errors[:message_senders].should_not include I18n.t('sender_as_recipient')

  end
end