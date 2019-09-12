class HomePagesController < ApplicationController
  include StoresHelper

  def index
    province_id = params[:province_id].present? ? params[:province_id] : Settings.province_default
    @stores = Store.ransack.result.includes(:district).by_province_id(province_id)
      .page(params[:page]).per Settings.manager.combo.num_in_page
    respond_to do |format|
      format.html
      format.js
    end
  end
end
