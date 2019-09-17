class CartsController < ApplicationController
  skip_load_and_authorize_resource
  include CartsHelper

  def create
    type = params[:type]
    quantity = params[:quantity]
    id = params[:product_id].present? ? params[:product_id] : params[:combo_id]
    add_to_cart type, quantity, id

    respond_to :js
  end

  def update
    type = params[:type]
    quantity = params[:quantity]
    id = params[:id]

    update_cart type, quantity, id
  end

  def destroy
    bill_detailable_type = params[:bill_detailable_type]
    bill_detailable_id = params[:bill_detailable_id]
    destroy_cart bill_detailable_type, bill_detailable_id
    
    redirect_to orders_path
  end
end
