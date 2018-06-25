class TeamsController < ApplicationController
  def index
    @teams = Team.all.to_a
  end

  def show
    @team = Team.find(params[:id])
  end
end
