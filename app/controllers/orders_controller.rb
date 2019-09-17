class OrdersController < ApplicationController
  skip_load_and_authorize_resource

  def index
    @bill_details = []
    session[:shopping_cart].each do |item|
      @bill_details << BillDetail.new(bill_detailable_type: item["bill_detailable_type"], 
        bill_detailable_id: item["bill_detailable_id"], count: item["count"])
    end
  end

  def show
    @bill_details = []
    session[:shopping_cart].each do |item|
      @bill_details << BillDetail.new(bill_detailable_type: item["bill_detailable_type"], 
        bill_detailable_id: item["bill_detailable_id"], count: item["count"])
    end
  end

  def create
    @bill_details = []
    session[:shopping_cart].each do |item|
      @bill_details << BillDetail.new(bill_detailable_type: item["bill_detailable_type"], 
        bill_detailable_id: item["bill_detailable_id"], count: item["count"])
    end

    store_ids(@bill_details).each do |store_id|
      @bill = Bill.new(store_id: store_id, user_id: current_user.id, address: params[:address])
      @bill.save
      @bill_details.each do |bill_detail|
        bill_detail.bill_id = @bill.id
        bill_detail.price = bill_detail.bill_detailable_price
        bill_detail.save if bill_detail.bill_detailable_store_id.eql? store_id
      end
    end
    session[:shopping_cart] = []

    flash[:success] = t(".order_success")
    redirect_to root_path
  end

  def store_ids bill_details
    @bill_details.map(&:bill_detailable_store_id).uniq
  end
end
