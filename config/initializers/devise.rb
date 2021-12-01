# frozen_string_literal: true

class TurboFailureApp < Devise::FailureApp
  def respond
    if request_format == :turbo_stream
      redirect
    else
      super
    end
  end

  def skip_format?
    %w(html turbo_stream */*).include? request_format.to_s
  end
end

Devise.setup do |config|
  config.parent_controller = 'TurboController'
  config.mailer_sender = 'tien.nguyen.1026@hcmut.edu.vn'
  config.mailer = 'Devise::Mailer'
  config.parent_mailer = 'ApplicationMailer'

  require 'devise/orm/active_record'

  config.case_insensitive_keys = [:email]
  config.strip_whitespace_keys = [:email]
  config.paranoid = true
  config.skip_session_storage = [:http_auth]
  config.stretches = Rails.env.test? ? 1 : 12
  config.invite_key = { email: /\A[^@]+@[^@]+\z/, name: nil }
  config.validate_on_invite = true
  config.reconfirmable = true
  config.expire_all_remember_me_on_sign_out = true
  config.password_length = 6..128
  config.email_regexp = /\A[^@\s]+@[^@\s]+\z/
  config.reset_password_within = 6.hours
  config.navigational_formats = ['*/*', :html, :turbo_stream]
  config.sign_out_via = :delete
  config.warden do |manager|
    manager.failure_app = TurboFailureApp
  end
  config.omniauth :google_oauth2, Settings.omniauth.google_app_id, Settings.omniauth.google_app_secret, scope: 'userinfo.email,userinfo.profile'
end

OmniAuth.config.allowed_request_methods = %i[get]