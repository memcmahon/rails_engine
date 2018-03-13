class Api::V1::Merchants::SearchController < ApplicationController
  def index
    if params[:id]
      render json: Merchant.find(params[:id])
    end
  end
end
