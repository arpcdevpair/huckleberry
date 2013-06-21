require 'spec_helper'

describe ProfilesController do
  include Devise::TestHelpers

  let(:valid_attributes) { { "text" => "MyString" } }

  describe 'approved user' do
    before do
      controller.stub(:authenticate_user!).and_return true
      login_approved
    end
    describe "GET show" do
      before do
        get :show, { initials: users(:approved).initials }
      end
      it "returns matching user" do
        assigns(:user).should eq(users(:approved))

      end
    end
    describe 'GET index'  do
      it 'assigns users' do
        get :index, { }
        assigns(:profile_users).should include users(:admin)
        assigns(:profile_users).should include users(:approved)
        assigns(:profile_users).should include users(:unapproved)
      end
    end
  end
end
