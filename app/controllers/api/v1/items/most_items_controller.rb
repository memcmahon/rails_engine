class Api::V1::Items::MostItemsController < ApplicationController
  def index
    render json: Item.ranked_by_sale(params[:quantity].to_i)
  end
end
