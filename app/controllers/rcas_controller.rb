class RcasController < ApplicationController
  def index
    @rcas = Rca.all.to_a
  end

  def new
    @rca = Rca.new
    @teams = Team.all.to_a
    @rca.user = User.new
  end

  def create
    @rca = Rca.new(rca_params)
    @rca.user = User.new(user_params)
    @teams = Team.all.to_a
    if @rca.user.save
      if @rca.save
        redirect_to rcas_path
      else
        render 'new'
      end
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
    @teams = Team.all.to_a
    if @rca.user.update(user_params)
      if @rca.update(rca_params)
        redirect_to rcas_path
      else
        render 'edit'
      end
    else
      render 'edit'
    end
  end

  def destroy
    @rca = Rca.find(params[:id])
    @rca.destroy
    redirect_to rcas_path
  end

  def show
    @rca= Rca.find(params[:id])
  end

  private

  def rca_params
    params.require(:rca).permit(:title, :description, :status, :team_id)
  end

  def user_params
    params.require(:user).permit(:email)
  end
end
