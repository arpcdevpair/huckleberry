require 'spec_helper'
include Warden::Test::Helpers

describe "Messages" do
  describe "GET /messages" do
    describe "unauthenticated" do
      it "redirects to new user session" do
        get messages_path
        response.should redirect_to(new_user_session_url)
      end
    end
    describe "approved" do
      it "shows messages" do
        login_as users(:approved)
        get messages_path
        response.should be_ok
      end
      after do
        Warden.test_reset!
      end
    end
    describe "admin" do
      it "shows messages" do
        login_as users(:admin)
        get messages_path
        response.should be_ok
      end
      after do
        Warden.test_reset!
      end
    end
    describe "pending approval" do
      it "redirects to new user session" do
        login_as users(:unapproved)
        get messages_path
        response.should redirect_to(new_user_session_url)
      end
      after do
        Warden.test_reset!
      end
    end
  end
end
