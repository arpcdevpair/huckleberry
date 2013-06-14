class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :set_globals
  after_filter :user_activity
  
  def set_globals
    @channels = Channel.order('name').limit(30)
    @users = User.order('initials').limit(30)   
  end
  
  private

  def user_activity
    current_user.update_attribute(:last_active_at, Time.now)
  end
  
end
