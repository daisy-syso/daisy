class DrugsController < ApplicationController
  before_action :set_drug, only: [:show]

  def index
    @drugs = Drugs::Drug.all.page(params[:page]).per(params[:per])
  end

  def show
    # debugger
  end

  private
    def set_drug
      @drug = Drugs::Drug.find(params[:id])
    end
end