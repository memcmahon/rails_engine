class Api::V1::Merchants::RevenueByDateController < ApplicationController

  def show
    date = params[:date].to_date
    render json: Invoice.all, date: date, serializer: MerchantRevenueByDateSerializer
  end
end
