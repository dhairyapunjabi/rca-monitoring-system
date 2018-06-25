class TeamsController < ApplicationController
  def index
    @teams = Team.all.to_a
  end
end
