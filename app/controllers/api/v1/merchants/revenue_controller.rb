class Api::V1::Merchants::RevenueController < ApplicationController
  def index
    render json: Merchant.rank_by_revenue(revenue_params[:quantity]), serializer: false
  end

  def show
    render json: Merchant.find(params[:id]), created_at_search: created_at_search, serializer: MerchantRevenueSerializer
  end

  private

  def created_at_search
    if revenue_params[:date]
      {created_at: (Date.parse(revenue_params[:date]).beginning_of_day..Date.parse(revenue_params[:date]).end_of_day)}
    end
  end

  def revenue_params
    params.permit(:quantity, :date, :id)
  end
end
