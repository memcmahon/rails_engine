class Api::V1::Merchants::MerchantItemsController < ApplicationController

  def show
    render json: Merchant.find(params[:id]), serializer: MerchantItemsSerializer
  end
end