class Api::V1::Merchants::SearchController < ApplicationController
  def index
    if params[:id]
      render json: Merchant.find(params[:id])
    elsif params[:name]
      render json: Merchant.find_by_name('name', params[:name])
    end
  end
end
