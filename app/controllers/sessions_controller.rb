class SessionsController < ApplicationController

  def create
    user = User.update_or_create(request.env["omniauth.auth"])
    session[:id] = user.id
    if user.role
      redirect_to root_path
    else
      redirect_to additional_information_path
    end
  end

  def destroy
    session.clear
    redirect_to root_path
  end

end