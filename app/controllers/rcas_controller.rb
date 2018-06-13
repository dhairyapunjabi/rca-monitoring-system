class RcasController < ApplicationController
  def index
    @rcas = Rca.all.to_a
  end

  def new
    @rca = Rca.new
  end
end
