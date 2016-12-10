class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by_credentials(
      session_params[:username],
      session_params[:password]
    )

    if user
      login_user(user)
      redirect_to subs_url
    else
      flash.now[:errors] = ["invalid credentials"]
      render :new
    end
  end

  def destroy
    logout_user
    redirect_to subs_url
  end

  private

  def session_params
    params.require(:user).permit(:username, :password)
  end
end
