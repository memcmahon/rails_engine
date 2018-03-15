class Api::V1::Items::SearchController < ApplicationController

  def show
    if item_params.present?
      render json: Item.find_by_attribute(item_params)
    else
      head 404, "content_type" => 'text/plain'
    end
  end

  def index
    if item_params.present?
      render json: Item.find_all_by_attribute(item_params)
    else
      head 404, "content_type" => 'text/plain'
    end
  end

  private

  def item_params
    if params[:unit_price]
      converted_unit_price = (params[:unit_price].to_f * 100.00).round(0).to_s
      {unit_price: converted_unit_price}
    else
      params.permit(:id, :name, :description, :unit_price, :merchant_id, :created_at, :updated_at)
    end
  end
end
