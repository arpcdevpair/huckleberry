require 'spec_helper'

describe MessagesHelper do
  before(:each) do
    @user = stub_model(User, initials: 'ABC', name: 'Ann Bell-Cap')
    @message = stub_model(Message, text: 'Hello! @ABC is my friend', message_recipients: [@user])
  end

  describe 'to_html' do
    before do
      @html = helper.to_html @message
    end
    it 'converts recipient initials to link to profile' do
      @html.should include user_path(@user)
    end

    it 'replaces recipient name with initials' do
      @html.should include ">#{@user.name}<"
      @html.should_not include ">#{@user.initials}<"
    end
  end
end
