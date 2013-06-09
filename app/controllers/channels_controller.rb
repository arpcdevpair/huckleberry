class ChannelsController < ApplicationController
  def show
    @channel = Channel.find_by_name(params[:name])
    @messages = @channel.channelMessages.map(&:message)

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user }
    end
  end

end