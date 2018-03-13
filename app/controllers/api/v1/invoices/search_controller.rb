class Api::V1::Invoices::SearchController < ApplicationController

  def show
    if invoice_params
      render json: Invoice.find_by(invoice_find_by)
    else
      head 404, "content_type" => 'text/plain'
    end
  end

  def index
    if invoice_params
      render json: Invoice.where(invoice_find_by)
    else
      head 404, "content_type" => 'text/plain'
    end
  end

  private

  def invoice_params
    params[:id] || params[:customer_id] || params[:merchant_id] || params[:status] || params[:created_at] || params[:updated_at]
  end

  def invoice_find_by
    params.permit(:id, :customer_id, :merchant_id, :status, :created_at, :updated_at).to_hash
  end
end
