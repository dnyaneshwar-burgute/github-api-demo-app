# frozen_string_literal: true

# SessionsController
class SessionsController < ApplicationController
  def create
    auth = request.env['omniauth.auth']
    user = User.find_by_provider_and_uid(auth['provider'], auth['uid']) || User.create_with_omniauth(auth)
    # TO DO (not considering the scenario login may change)
    session[:token] = auth['credentials']['token']
    session[:user_id] = user.id
    redirect_to root_url, notice: I18n.t('controllers.sessions.login')
  end

  def destroy
    session[:token] = nil
    session[:user_id] = nil
    redirect_to root_url, notice: I18n.t('controllers.sessions.sign_out')
  end
end
