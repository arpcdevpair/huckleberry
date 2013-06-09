class AuthenticatedController < ApplicationController
  before_filter :authenticate_approved_user!
  
  protected 
  def authenticate_approved_user!()
    authenticate_user!
    unless current_user.approved?
      flash[:notice] = I18n.t("devise.failure.not_approved")
      sign_out current_user
      redirect_to new_user_session_url
    end
  end
end