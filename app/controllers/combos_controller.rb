class CombosController < ApplicationController
  before_action :load_combos, only: %i(index)

  def index
    respond_to :js
  end

  private

  def load_combos
    limit = Settings.num_in_web
    offset = Settings.num_in_web * (params[:page].to_i + Settings.zero)
    @combos = Combo.by_store_id(params[:store_id]).limit(limit).offset offset
  end
end
