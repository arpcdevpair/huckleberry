require 'spec_helper'

describe 'profiles/index' do
  before(:each) do
    @profile_user_1 = stub_model(User, name: 'John Smith', initials: 'JS')
    assign(:profile_users, [@profile_user_1])

    assign(:channels, [stub_model(Channel, :name => 'Name')])
    assign(:users, [stub_model(User, :name => 'Name')])
    assign(:message, stub_model(Message, text: '', errors: []))
  end

  it 'renders a list of users' do
    render
    assert_select 'tr>td:nth-of-type(2)', text: @profile_user_1.name, count: 1
  end
end
