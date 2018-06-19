class RcasController < ApplicationController
  def index
    @rcas = Rca.all.to_a
  end

  def new
    @rca = Rca.new
    @teams = Team.all.to_a
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
    @teams = Team.all.to_a
  end

  def update
    @rca = Rca.find(params[:id])
    if @rca.update(rca_params)
      redirect_to rcas_path
    else
      render 'edit'
    end
  end

  def destroy
    @rca = Rca.find(params[:id])
    @rca.destroy
    redirect_to rcas_path
  end

  private

  def rca_params
    params.require(:rca).permit(:title, :description, :users, :status, :team_id)
  end
end
