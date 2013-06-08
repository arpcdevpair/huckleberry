class ProfilesController < ApplicationController
  def show
    puts :initials
    @user = User.find_by_initials(params[:initials])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user }
    end
  end

end