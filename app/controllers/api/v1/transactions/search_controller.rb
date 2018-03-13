class Api::V1::Transactions::SearchController < ApplicationController
  def index
    if !transaction_params.empty?
      render json: Transaction.where(transaction_params)
    else
      head 404, "content-type" => "text/plain"
    end
  end

  def show
    if !transaction_params.empty?
      render json: Transaction.find_by(transaction_params)
    else
      head 404, "content-type" => "text/plain"
    end
  end

  private
    def transaction_params
      params.permit(:id, :credit_card_number, :result, :invoice_id, :created_at, :updated_at)
    end
end
