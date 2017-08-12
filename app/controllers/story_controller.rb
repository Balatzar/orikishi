class StoryController < ApplicationController
  def new
    @story = Story.new
  end

  def create
    story = Story.create_new_story params.permit(:name, :text, :image)
    redirect_to "/#{story.slug}"
  end
end