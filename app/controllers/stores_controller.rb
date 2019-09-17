class StoresController < ApplicationController
  include StoresHelper

  before_action :load_combos, only: %i(show)
  before_action :load_products, only: %i(show)

  def show; end

  private
  
  def load_combos
    @combos = Combo.by_store_id(params[:id]).take Settings.num_in_web
  end

  def load_products
    @products = Product.by_store_id(params[:id]).take Settings.num_in_web
  end
end
