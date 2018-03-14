class Api::V1::Merchants::RevenueController < ApplicationController
  def show
    render json: Merchant.rank_by_revenue(revenue_params)
  end


  private

  def revenue_params
    params.permit(:quantity)
  end
end
