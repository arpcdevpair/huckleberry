require 'spec_helper'

describe MessagesController do

  describe "routing" do
    it "routes to #index" do
      get("/messages").should route_to("messages#index")
    end

    it "routes to #show" do
      message = messages(:message_1_day_1)
      get("/messages/#{message.id}").should route_to('messages#show', id: message.id.to_s)
    end

    it "routes to #create" do
      post("/messages").should route_to("messages#create")
    end

    it "should not be route to #edit" do
      expect(put: "/messages/1").not_to be_routable
    end
    it "should not route to #update" do
      expect(put: "/messages/1").not_to be_routable
    end
    it "should not route to #destroy" do
      expect(delete: "/messages/1").not_to be_routable
    end
    end
end
