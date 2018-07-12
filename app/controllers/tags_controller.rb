class TagsController < ApplicationController
  def index
    @tags = Tag.all.to_a
    @tags = @tags.sort { |tag1 ,tag2| tag2.rcas.count <=> tag1.rcas.count }
  end

  def show
    @tag = Tag.find(params[:id])
  end
end
