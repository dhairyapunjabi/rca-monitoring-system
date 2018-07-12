class TeamsController < ApplicationController
  def index
    @teams = Team.all.to_a
    @teams = @teams.sort { |team1, team2| team1.name <=> team2.name }
  end

  def show
    @team = Team.find(params[:id])
  end
end
