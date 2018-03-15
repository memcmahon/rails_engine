class Api::V1::Items::ItemMerchantController < ApplicationController
  def show
    render json: Item.find(params[:id]).merchant
  end
end
