class OrikishiController < ApplicationController
  def index
    @orikishi_engine_props = { story: Story.find_by(slug: params[:story]).jsonify }
  end
end
