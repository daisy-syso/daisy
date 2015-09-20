class DrugstoresController < ApplicationController
  before_action :set_drugstore, only: [:show]

  def index
    @drugstores = Drugs::Drugstore.all.page(params[:page]).per(params[:per])
  end

  def show
    # debugger
  end

  private
    def set_drugstore
      @drugstore = Drugs::Drugstore.find(params[:id])
    end
end