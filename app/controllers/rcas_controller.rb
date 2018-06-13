class RcasController < ApplicationController
def index
  @rcas = Rca.all.to_a
 end
end

