class Api::V1::Merchants::SearchController < ApplicationController
  def index
    if params[:id]
      render json: Merchant.where(id: params[:id])
    end
  end

  def show
    if params[:id]
      render json: Merchant.find(params[:id])
    elsif params[:name]
      render json: Merchant.find_by_name('name', params[:name])
    elsif params[:created_at]
      render json: Merchant.find_by_created_at('created_at', Time.parse(params[:created_at]).in_time_zone('UTC')).first
    elsif params[:updated_at]
      render json: Merchant.find_by_updated_at('updated_at', Time.parse(params[:updated_at]).in_time_zone('UTC')).first
    end
  end
end
