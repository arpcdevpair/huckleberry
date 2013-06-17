require 'spec_helper'

describe Message do
  before do
    @message = Message.new
    @alice = stub_model(User, name: 'Alice')
    @bob = stub_model(User, name: 'Bob')
  end

  it 'must not have sender as recipient' do

    message = Message.new
    message.message_senders << @alice
    message.message_recipients << @alice
    message.valid?
    message.errors[:senders].should include I18n.t('errors.messages.model.message.includes_recipients')

    message = Message.new
    message.message_senders << @alice
    message.message_recipients << @bob
    message.valid?
    message.errors[:senders].should_not include I18n.t('errors.messages.model.message.includes_recipients')

  end

  it 'must have a recipient' do
    message = Message.new
    message.valid?
    message.errors[:message_recipients].should include I18n.t('errors.messages.blank')

    message = Message.new
    message.message_recipients << @alice
    message.valid?
    message.errors[:message_recipients].should_not include I18n.t('errors.messages.blank')
  end
end