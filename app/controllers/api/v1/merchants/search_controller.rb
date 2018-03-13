class Api::V1::Merchants::SearchController < ApplicationController
  def index
    if params[:id]
      render json: Merchant.where(id: params[:id])
    elsif params[:name]
      render json: Merchant.find_all_by_name('name', params[:name])
    elsif params[:created_at]
      render json: Merchant.where(merchant_params)
    elsif params[:updated_at]
      render json: Merchant.where(merchant_params)
    end
  end

  def show
    if params[:id]
      render json: Merchant.find(params[:id])
    elsif params[:name]
      render json: Merchant.find_by_name('name', params[:name])
    elsif params[:created_at]
      render json: Merchant.find_by(merchant_params)
    elsif params[:updated_at]
      render json: Merchant.find_by(merchant_params)
    end
  end

  private
    def merchant_params
      params.permit(:created_at, :updated_at)
    end
end
