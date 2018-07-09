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
    @tags = tag_params
    temporary_action_item = Actionitem.new
    @actionitems[:list].each do |actionitem|
      temporary_action_item.assign_attributes(actionitem)
      temporary_action_item.rca = @rca
      if !(temporary_action_item.valid?)
        break
      end
    end

    temporary_tag = Tag.new(name: "Ruby")
    @tags.each do |tag_name|
      temporary_tag.name = tag_name
      if !(temporary_tag.valid?)
        break
      end
    end

    if (temporary_tag.valid? & temporary_action_item.valid? & @rca.user.valid? & @rca.valid?)
      @rca.user.save
      @rca.save
      @actionitems[:list].each do |actionitem|
        @rca.actionitems.create(actionitem)
      end
      @tags.each do |tag_name|
        @rca.tags << Tag.find_or_create_by(name: tag_name)
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
      @rca.user.update
      @rca.update
      @rca.actionitems.delete_all
      @actionitems[:list].each do |actionitem|
        @rca.actionitems.create(actionitem)
      end
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

  def tag_params
    params.fetch(:tag).permit(:list)
    params[:tag][:list].split(", ")
  end
end
