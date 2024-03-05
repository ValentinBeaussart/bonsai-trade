# frozen_string_literal: true

module Api
  module V1
    class AdsController < ApplicationController # rubocop:disable Style/Documentation
      # before_action :authorize_access_request!
      before_action :set_ad, only: %i[show update destroy]

      # GET /ads
      def index
        @ads = Ad.includes(:user, :category).all

        render json: formatted_ads
      end

      # GET /ads/1
      def show
        render json: @ad
      end

      # POST /ads
      def create
        @ad = current_user.ads.build(ad_params)

        if @ad.save
          render json: @ad, status: :created, location: @ad
        else
          render json: @ad.errors, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /ads/1
      def update
        if @ad.update(ad_params)
          render json: @ad
        else
          render json: @ad.errors, status: :unprocessable_entity
        end
      end

      # DELETE /ads/1
      def destroy
        @ad.destroy!
      end

      private

      # Format the created_at attribute
      def formatted_ads
        @ads.as_json(include: { user: { only: %i[id username] }, category: { only: %i[id name] } }).map do |ad|
          ad.merge(created_at: format_date(ad['created_at']))
        end
      end

      def format_date(date_string)
        date = Date.parse(date_string)
        date.strftime('%e %B %Y')
      end

      # Use callbacks to share common setup or constraints between actions.
      def set_ad
        @ad = Ad.find(params[:id])
      end

      # Only allow a list of trusted parameters through.
      def ad_params
        params.require(:ad).permit(:name, :latin_name, :description, :place, :price, :category_id, :user_id)
      end
    end
  end
end
