class Api::V1::Customers::SearchController < ApplicationController
  def index
    if !customer_params.empty?
      render json: Customer.where(customer_params)
    else
      head 404, "content-type" => "text/plain"
    end
  end

  def show
    if !customer_params.empty?
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
