
class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def google_oauth2
    @user = User.find_from_omniauth(request.env["omniauth.auth"])
    if @user
      sign_in @user
      # flash[:notice] = I18n.t 'devise.omniauth_callbacks.success', kind: 'Google'
      redirect_to root_path
    else
      redirect_to new_user_session_path, notice: 'Access Denied.'
    end
  end
end

