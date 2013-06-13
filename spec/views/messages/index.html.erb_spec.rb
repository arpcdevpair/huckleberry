require 'spec_helper'

describe "messages/index" do
  before(:each) do
    assign(:messages, [
      stub_model(Message, text: "Text", created_at: Time.now),
      stub_model(Message, text: "Text", created_at: Time.now) 
    ])
    assign(:channels, [stub_model(Channel, :name => "Name")])
    assign(:users, [stub_model(User, :name => "Name")])
    assign(:message, stub_model(Message, text: "", errors: []))
  end

  it "renders a list of messages" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Text".to_s, :count => 2
  end
end
