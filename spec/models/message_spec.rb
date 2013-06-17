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

  describe 'text' do
    it 'recipient tags must map to users' do
      message = Message.new
      message.text = 'Hello @abc'
      message.valid?
      message.errors[:text].should include '@abc not mapped'

      user = User.new(initials: 'abc', email: 'abc@127.0.0.1', password: 'abc123*(', name: 'ABC')
      user.valid?
      user.errors.full_messages.should eq []
      assert user.save

      message = Message.new
      message.text = "Hello @abc"
      message.valid?
      message.errors[:text].should_not include '@abc not mapped'
    end

    it 'sender tags must map to users' do
      message = Message.new
      message.text = 'Hello abc>'
      message.valid?
      message.errors[:text].should include 'abc> not mapped'

      user = User.new(initials: 'abc', email: 'abc@127.0.0.1', password: 'abc123*(', name: 'ABC')
      user.valid?
      user.errors.full_messages.should eq []
      assert user.save

      message = Message.new
      message.text = "Hello abc>"
      message.valid?
      message.errors[:text].should_not include 'abc> not mapped'
    end
  end
end