class Api::V1::Invoices::SearchController < ApplicationController

  def show
    if params[:id].present?
      render json: Invoice.find(params[:id])
    elsif params[:customer_id].present?
      render json: Invoice.find_by(customer_id: params[:customer_id])
    elsif params[:merchant_id].present?
      render json: Invoice.find_by(merchant_id: params[:merchant_id])
    elsif params[:status].present?
      render json: Invoice.find_by(status: params[:status])
    elsif params[:created_at].present?
      render json: Invoice.find_by(created_at: Time.parse(params[:created_at]))
    elsif params[:updated_at].present?
      render json: Invoice.find_by(updated_at: params[:updated_at])
    else
      render file: 'public/404.html'
    end
  end

  def index
    if params[:id].present?
      render json: Invoice.where(id: params[:id])
    elsif params[:customer_id].present?
      render json: Invoice.where(customer_id: params[:customer_id])
    elsif params[:merchant_id].present?
      render json: Invoice.where(merchant_id: params[:merchant_id])
    elsif params[:status].present?
      render json: Invoice.where(status: params[:status])
    elsif params[:created_at].present?
      render json: Invoice.where(created_at: Time.parse(params[:created_at]))
    elsif params[:updated_at].present?
      render json: Invoice.where(updated_at: params[:updated_at])
    else
      render file: 'public/404.html'
    end
  end
end
