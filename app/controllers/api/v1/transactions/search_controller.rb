class Api::V1::Transactions::SearchController < ApplicationController
  def show
    if transaction_params
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
