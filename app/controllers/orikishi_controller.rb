class OrikishiController < ApplicationController
  before_action :set_story, only: [:index]

  def index
    @orikishi_engine_props = { story: @story.jsonify, add_follow_up_path: "/#{@story.slug}/add_follow_up" }
  end

  def add_follow_up
    frame = Frame.find(params[:frame])
    new_frame = frame.add_follow_up params.require(:newFrame).permit(:text, :image)
    res = {
      new_frame: {
        id: new_frame.id,
        text: new_frame.text,
        branches: new_frame.branches.map { |b| b.id },
        url: new_frame.image.url(:medium)
      },
      old_frame_id: frame.id
    }
    render json: res
  end

  private

  def set_story
    @story = Story.find_by(slug: params[:story])
  end
end
