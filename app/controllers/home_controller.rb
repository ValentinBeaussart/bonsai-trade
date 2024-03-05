# frozen_string_literal: true

class HomeController < ApplicationController # rubocop:disable Style/Documentation
  def index
    @ads = Ad.all
    render json: @ads
  end
end
