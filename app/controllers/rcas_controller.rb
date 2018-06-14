class RcasController < ApplicationController
  def index
    @rcas = Rca.all.to_a
  end

  def new
    @rca = Rca.new
  end

  def create
    @rca = Rca.new(rca_params)
    if @rca.save
      redirect_to rcas_path
    else
      render 'new'
    end
  end

  def edit
    @rca = Rca.find(params[:id])
  end

  private
  def rca_params
    params.require(:rca).permit(:title, :description, :users, :status, :team_id)
  end
end
