class ApplicationController < ActionController::Base
  helper_method :current_user #全てのビューから使えるようにする。
  before_action :login_required

  private
    def current_user
      @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
    end

    def authenticate_user
      if current_user == nil
        redirect_to posts_path
      end
    end

    def login_required
      redirect_to login_url unless current_user
    end

end
