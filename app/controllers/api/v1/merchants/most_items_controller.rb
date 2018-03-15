class Api::V1::Merchants::MostItemsController < ApplicationController
  def index
    render json: Merchant.ranked_by_item(params[:quantity])
  end
end
