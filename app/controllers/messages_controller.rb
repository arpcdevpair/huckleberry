class MessagesController < ApplicationController
  before_filter :authenticate_user!
  # GET /messages
  # GET /messages.json
  def index
    @message = Message.new()
    @messages = Message.order('created_at desc').limit(10)
    @channels = Channel.order('created_at desc').limit(30)
    
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @messages }
    end
  end

  # GET /messages/1
  # GET /messages/1.json
  def show
    @message = Message.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @message }
    end
  end

  # GET /messages/new
  # GET /messages/new.json
  def new
    @message = Message.new
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @message }
    end
  end

  # GET /messages/1/edit
  def edit
    @message = Message.find(params[:id])
  end

  # POST /messages
  # POST /messages.json
  def create
 
    @message = Message.new(params[:message])   

    pattern = /([\w\.]+)>/
    matches = @message.text.scan(pattern).map(&:first).map(&:upcase).uniq.each do |initials|
      user = User.find_by_initials(initials)
      if user.present?
        sender = Sender.new(user: user, message: @message)
        @message.senders << sender
      end
    end
    
    pattern = /@([\w\.]+)/
    matches = @message.text.scan(pattern).map(&:first).map(&:upcase).uniq.each do |initials|
      user = User.find_by_initials(initials)
      if user.present?
        recipient = Recipient.new(user: user, message: @message)
        @message.recipients << recipient
      end
    end

    pattern = /#([\w\.]+)/
    @message.text.scan(pattern).map(&:first).map(&:upcase).uniq.each do |name|
      channel = Channel.find_by_name(name)
      if !channel.present?
        channel = Channel.new(name: name)
      end
      
     channel_message = ChannelMessage.new(channel: channel, message: @message)
     @message.channelMessages << channel_message     
    end

    respond_to do |format|
      if @message.save
        flash[:notice] = 'Message was successfully created.'
        format.html { redirect_to action: "index" }
        format.json { render json: @message, status: :created, location: @message }
      else
        format.html { render action: "new" }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /messages/1
  # PUT /messages/1.json
  def update
    @message = Message.find(params[:id])

    respond_to do |format|
      if @message.update_attributes(params[:message])
        format.html { redirect_to @message, notice: 'Message was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /messages/1
  # DELETE /messages/1.json
  def destroy
    @message = Message.find(params[:id])
    @message.destroy

    respond_to do |format|
      format.html { redirect_to messages_url }
      format.json { head :no_content }
    end
  end
end
