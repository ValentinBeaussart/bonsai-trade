# frozen_string_literal: true

class RefreshController < ApplicationController # rubocop:disable Style/Documentation
  before_action :authorize_refresh_by_access_request!

  def create
    session = JWTSessions::Session.new(payload: claimless_payload, refresh_by_access_allowed: true)
    tokens = session.refresh_by_access_allowed do
      raise JWTSessions::Errors::Unauthorized, 'Un problème est survenu.'
    end

    response.set_cookie(JWTSessions.access_cookie, value: tokens[:access], httponly: true,
                                                   secure: Rails.env.production?)

    render json: { csrf: tokens[:csrf] }
  end
end
