class Api::V1::Merchants::SearchController < ApplicationController
  def index
    if merchant_params.present?
      render json: Merchant.find_all_by_attribute(merchant_params)
    else
      head 404, "content-type" => "text/plain"
    end
  end

  def show
    if merchant_params.present?
      render json: Merchant.find_by_attribute(merchant_params)
    else
      head 404, "content-type" => "text/plain"
    end
  end

  private
   def merchant_params
     params.permit(:id, :name, :created_at, :updated_at)
   end
end
