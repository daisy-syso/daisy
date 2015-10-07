class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :get_current_editor

  def check_auth
    if session[:editor] == nil
      redirect_to logout_editors_session_index_path
    end
  end

  def get_current_editor
    email = session[:editor]
    @current_editor = Editor.where(email: email).first
  end
end
