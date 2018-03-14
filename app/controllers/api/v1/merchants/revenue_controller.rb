class Api::V1::Merchants::RevenueController < ApplicationController
  def index
    render json: Merchant.rank_by_revenue(revenue_params[:quantity])
  end

  private

  def revenue_params
    params.permit(:quantity)
  end
end
