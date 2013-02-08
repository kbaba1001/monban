require 'bcrypt'
require 'monban/controller_helpers/sign_in'
require 'monban/controller_helpers/sign_out'
require 'monban/controller_helpers/sign_up'
require 'monban/controller_helpers/authentication'
require 'active_support/concern'

module Monban
  module ControllerHelpers
    extend ActiveSupport::Concern
    included do
      helper_method :current_user, :signed_in?
    end

    def sign_in user
      SignIn.new(user, cookies).perform
    end

    def sign_out
      SignOut.new(cookies).perform
    end

    def sign_up user_params
      SignUp.new(user_params).perform
    end

    def authenticate_session session_params
      email = session_params[:email]
      password = session_params[:password]
      user = User.find_by_email(email)
      authenticate user, password
    end

    def authenticate user, password
      Authentication.new(user, password).authenticated?
    end

    def current_user
      User.find_by_id user_session_variable
    end

    def signed_in?
      current_user
    end

    def user_session_variable
      cookies.signed[:user_id]
    end

    def require_login
      unless signed_in?
        redirect_to '/sign_in'
      end
    end
  end
end
