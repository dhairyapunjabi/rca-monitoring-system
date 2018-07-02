class TagsController < ApplicationController
  def index
    @tags = Tag.all.to_a
  end

  def show
    @tag = Tag.find(params[:id])
  end
end
