require 'spec_helper'

describe 'profiles/show' do
  before(:each) do
    assign(:user, stub_model(User, name:'Bryant', gravatar_hash: 'my_hash', online?: false,
      sent_messages: [ stub_model(Message, text: 'sent message 1', created_at: Time.now), stub_model(Message, text: 'sent message 2', created_at: Time.now)],
      received_messages: [ stub_model(Message, text: 'received message 1', created_at: Time.now), stub_model(Message, text: 'received message 2', created_at: Time.now)]))
    assign(:channels, [stub_model(Channel, :name => 'Name')])
    assign(:users, [stub_model(User, :name => 'Name')])
    assign(:message, stub_model(Message, text: '', errors: []))
  end

  it 'displays the name' do
    render
    assert_select "span#name", text: "Bryant".to_s, count: 1
  end

  it "has an image representing the user" do
    render
    assert_select "img#gravatar", count: 1
  end

  it 'renders a list of sent messages' do
    render
    assert_select 'table#sent_messages>tr', :count => 2
  end

  describe "online" do
    before do
      assign(:user, stub_model(User, name:'Bryant', gravatar_hash: 'my_hash', online?: true))
    end
    it "displays correct status" do
      render
      assert_select "span#online", text: "Online!".to_s, count: 1
    end
  end

  describe "offline" do
    before do
      assign(:user, stub_model(User, name:'Bryant', gravatar_hash: 'my_hash', online?: false))
    end
    it "displays correct status" do
      render
      assert_select "span#online", text: "Offline".to_s, count: 1
    end
  end
end
