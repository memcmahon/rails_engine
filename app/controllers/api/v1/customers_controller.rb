class Api::V1::CustomersController < ApplicationController
  def index
    render json: Customer.all, each_serializer: SimpleCustomerSerializer
  end

  def show
    render json: Customer.find(params[:id])
  end
end
