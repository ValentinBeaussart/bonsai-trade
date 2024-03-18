# frozen_string_literal: true

class SigninController < ApplicationController # rubocop:disable Style/Documentation
  before_action :authorize_access_request!, only: [:destroy]

  def create # rubocop:disable Metrics/AbcSize,Metrics/MethodLength
    user = User.find_by(email: params[:email])

    if user&.authenticate(params[:password])
      payload = { user_id: user.id }
      session = JWTSessions::Session.new(payload:, refresh_by_access_allowed: true)
      tokens = session.login

      response.set_cookie(JWTSessions.access_cookie, value: tokens[:access], httponly: true,
                                                     secure: Rails.env.production?)

      render json: { csrf: tokens[:csrf] }
    else
      not_found
    end
  end

  def destroy
    session = JWTSessions::Session.new(payload:)
    session.flush_by_access_payload
    render json: :ok
  end

  private

  def not_found
    render json: { error: 'Adresse mail ou mot de passe incorrect.' }, status: :not_found
  end
end
