require 'spec_helper'

describe MessagesController do
  include Devise::TestHelpers

  let(:valid_attributes) { { "text" => "MyString" } }

  describe 'approved user' do
    before do
      controller.stub(:authenticate_user!).and_return true
      login_approved
    end
    describe "GET index" do
      before do
        get :index, {}
      end
      it "assigns 10 messages as @messages" do
        assigns(:messages).count.should eq(10)
      end
      it "assigns messages in descending order as @messages" do
        messages = assigns(:messages)
        descending_messages = messages.sort{|a,b|b.created_at <=> a.created_at}
        messages.should eq(descending_messages)
      end
      it "assigns most recent messages as @messages" do
        assigns(:messages).first.should eq(messages(:message_20_day_2))
      end
      it "assigns a new message as @message" do
        expect(assigns(:message)).to be_a_new( Message )
      end
    end
  
    describe "GET show" do
      it "assigns the requested message as @message" do
        message = Message.create! valid_attributes
        get :show, {:id => message.to_param}
        assigns(:message).should eq(message)
      end
    end
  
    describe "GET new" do
      it "assigns a new message as @message" do
        get :new, {}
        assigns(:message).should be_a_new(Message)
      end
    end
  
    describe "POST create" do
      describe "with valid params" do
        it "creates a new Message" do
          expect {
            post :create, {:message => valid_attributes}
          }.to change(Message, :count).by(1)
        end
  
        it "assigns a newly created message as @message" do
          post :create, {:message => valid_attributes}
          assigns(:message).should be_a(Message)
          assigns(:message).should be_persisted
        end
  
        it "redirects to the index" do
          post :create, {:message => valid_attributes}
          response.should redirect_to root_path
        end
      end
  
      describe "with invalid params" do
        it "assigns a newly created but unsaved message as @message" do
          # Trigger the behavior that occurs when invalid params are submitted
          Message.any_instance.stub(:save).and_return(false)
          post :create, {:message => { "text" => "invalid value" }}
          assigns(:message).should be_a_new(Message)
        end
  
        it "re-renders the 'new' template" do
          # Trigger the behavior that occurs when invalid params are submitted
          Message.any_instance.stub(:save).and_return(false)
          post :create, {:message => { "text" => "invalid value" }}
          response.should render_template("new")
        end
      end
    end
  end
end
