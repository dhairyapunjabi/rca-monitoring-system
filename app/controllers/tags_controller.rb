class TagsController < ApplicationController
  def index
    @tags = Tag.all.to_a
  end
end
