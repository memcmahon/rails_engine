class Api::V1::Merchants::RevenueByDateController < ApplicationController

  def show
    date = params[:date].to_date
    render json: Invoice.revenue_by_date(date)
  end
end
