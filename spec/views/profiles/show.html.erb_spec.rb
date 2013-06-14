require 'spec_helper'

describe "profiles/show" do
  before(:each) do
    assign(:user, stub_model(User, name:'Bryant', gravatar_hash: 'my_hash', online?: false))
    assign(:channels, [stub_model(Channel, :name => "Name")])
    assign(:users, [stub_model(User, :name => "Name")])
    assign(:message, stub_model(Message, text: "", errors: []))
  end

  it "displays the name" do
    render
    assert_select "span#Name", text: "Bryant".to_s, count: 1
  end
  
  it "has an image representing the user" do
    render
    assert_select "img#gravatar[src=?]", "http://www.gravatar.com/avatar/my_hash.jpg?s=64&amp;d=monsterid&amp;r=g", count: 1
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
