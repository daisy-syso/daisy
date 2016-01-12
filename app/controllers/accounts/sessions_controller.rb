class Accounts::SessionsController < Devise::SessionsController
  layout 'news/application'
# before_filter :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  def new
    super
  end

  # POST /resource/sign_in
  # def create
    # super

    # debugger

    # if news_account_signed_in?
      # redirect_to news_accounts_mine_path
    # else
      # redirect_to
    # end

  # end

  def after_sign_in_path_for(resource)
    news_accounts_mine_path
  end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.for(:sign_in) << :attribute
  # end
end
