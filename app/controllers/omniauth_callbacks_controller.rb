class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def google_oauth2
    @user = User.from_omniauth(request.env['omniauth.auth'])

    if @user
      flash[:notice] = I18n.t 'devise.omniauth_callbacks.success', kind: 'Google'
      sign_in_and_redirect @user, event: :authentication
    else
      session['devise.google_data'] = request.env['omniauth.auth'].except('extra')
      redirect_to new_user_session_url, alert: "Tài khoản với email #{request.env['omniauth.auth'].info.email} không tồn tại. Vui lòng liên hệ ban quản trị hệ thống để thiết lập tài khoản mới."
    end
  end
end