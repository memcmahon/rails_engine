class Api::V1::InvoiceItems::SearchController < ApplicationController

  def show
    if invoice_item_params.present?
      render json: InvoiceItem.find_by(invoice_item_params)
    else
      head 404, "content-type" => "text/plain"
    end
  end

  def index
    if invoice_item_params.present?
      render json: InvoiceItem.where(invoice_item_params)
    else
      head 404, "content-type" => "text/plain"
    end
  end

  private

  def invoice_item_params
    params.permit(:id, :item_id, :invoice_id, :quantity, :unit_price, :created_at, :updated_at)
  end
end
