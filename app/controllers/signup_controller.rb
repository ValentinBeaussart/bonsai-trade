# frozen_string_literal: true

class SignupController < ApplicationController # rubocop:disable Style/Documentation
  def create # rubocop:disable Metrics/MethodLength,Metrics/AbcSize,Metrics/CyclomaticComplexity,Metrics/PerceivedComplexity
    user = User.new(user_params)
    if user.save
      payload = { user_id: user.id }
      session = JWTSessions::Session.new(payload:, refresh_by_access_allowed: true)
      tokens = session.login

      response.set_cookie(JWTSessions.access_cookie, value: tokens[:access], httponly: true,
                                                     secure: Rails.env.production?)

      render json: { csrf: tokens[:csrf] }
    elsif user.errors[:username].include?('has already been taken')
      render json: { error: 'Le nom d\'utilisateur est déjà pris.' }, status: :unprocessable_entity
    elsif user.errors[:email].include?('has already been taken')
      render json: { error: 'L\'adresse email est déjà utilisée.' }, status: :unprocessable_entity
    elsif params[:password] != params[:password_confirmation]
      render json: { error: 'Les mots de passe ne correspondent pas.' }, status: :unprocessable_entity
    elsif user.errors[:email].include?('is invalid')
      render json: { error: 'L\'adresse email est invalide.' }, status: :unprocessable_entity
    elsif user.erros[:username].include?('is too short (minimum is 1 character)')
      render json: { error: 'Le nom d\'utilisateur est trop court (minimum 1 caractère).' },
             status: :unprocessable_entity
    elsif user.errors[:username].include?('is too long (maximum is 50 characters)')
      render json: { error: 'Le nom d\'utilisateur est trop long (maximum 50 caractères).' },
             status: :unprocessable_entity
    elsif user.errors[:email].include?('is too short (minimum is 6 characters)')
      render json: { error: 'L\'adresse email est trop courte (minimum 6 caractères).' },
             status: :unprocessable_entity
    elsif user.errors[:email].include?('is too long (maximum is 60 characters)')
      render json: { error: 'L\'adresse email est trop longue (maximum 60 caractères).' },
             status: :unprocessable_entity
    else
      render json: { error: user.errors.full_messages.join(' ') }, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.permit(:username, :email, :password, :password_confirmation)
  end
end
