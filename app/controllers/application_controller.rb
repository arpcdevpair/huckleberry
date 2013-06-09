class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :set_globals
  
  def set_globals
    @channels = Channel.order('name').limit(30)
    @users = User.order('initials').limit(30)   
  end
end
