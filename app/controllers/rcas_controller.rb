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
    @rca.user = User.find_or_initialize_by(user_params)
    @teams = Team.all.to_a
    @actionitems = actionitem_params
    temporary_action_item = Actionitem.new
    @actionitems[:list].each do |actionitem|
      temporary_action_item.assign_attributes(actionitem)
      temporary_action_item.rca = @rca
      if !(temporary_action_item.valid?)
        break
      end
    end

    if (temporary_action_item.valid? & @rca.user.valid? & @rca.valid?)
      @rca.user.save
      @rca.save
      @actionitems[:list].each do |actionitem|
        @rca.actionitems.create(actionitem)
      end
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
    @rca.assign_attributes(rca_params)
    @rca.user = User.find_or_initialize_by(user_params)
    @teams = Team.all.to_a
    if (@rca.user.update && @rca.update)
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

  def actionitem_params
    params[:actionitem][:list] = JSON.parse params[:actionitem][:list]
    params.require(:actionitem).permit(list:[:name, :status, :complete_by, :completed_on])
  end
end
