class StoriesController < ApplicationController
  def list
    @stories = get_stories
    @is_error = Common.error?(params[:error])
  end

  def add
    @story = Story.new
  end

  def create
    result = Story.create(story_params)
    is_success = Common.create_success?(result)
    result.set_contents_info(contents_params) if is_success
    redirect_to Common.list_path(is_success)
  end

  def edit
    @story = Story.where(id: params[:sid]).first
  end

  def update
    story = Story.where(id: params[:sid]).first
    is_success = story.update_attributes(story_params)
    story.set_contents_info(contents_params) if is_success
    redirect_to Common.list_path(is_success)
  end

  def active
    story = Story.where(id: params[:sid]).first
    is_success = story.toggle_active(is_active: params[:is_active], serial: 0)
    redirect_to Common.list_path(is_success)
  end

  private
  def story_params
    params.require(:story).permit(:volume_id, :title, :comment, :is_scene)
  end

  def contents_params
    params.require(:contents).permit(:file, :text)
  end

  def get_stories
    Story.where(volume_id: params[:vid]).active_by.serial_by
  end
end

