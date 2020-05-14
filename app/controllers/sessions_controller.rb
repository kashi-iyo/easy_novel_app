class SessionsController < ApplicationController
  skip_before_action :login_required

  def new
    @user = User.new
  end

  def create
    user = User.find_by(email: sessions_params[:email])

    if user&.authenticate(sessions_params[:password]) #ぼっち演算子を付与してnilを返すようにする。
      session[:user_id] = user.id
      redirect_to posts_url, notice: 'ログインしました。'
    else
      render :new
    end
  end

  def destroy
    reset_session
    redirect_to root_url, notice: 'ログアウトしました。'
  end

  private
    def sessions_params
      params.require(:sessions).permit(:email, :password)
    end
end
