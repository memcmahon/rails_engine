class Api::V1::Customers::SearchController < ApplicationController
  def show
    if customer_params
      render json: Customer.find_by(customer_params)
    else
      head 404, "content-type" => "text/plain"
    end
  end

  private
    def customer_params
      params.permit(:id, :first_name, :last_name, :created_at, :updated_at)
    end
end
