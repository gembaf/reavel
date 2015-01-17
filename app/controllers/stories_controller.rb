class StoriesController < ApplicationController
  before_action :get_story, only: [:edit, :update, :active]

  def list
    @stories = Story.unscoped.where(volume_id: params[:vid]).active_by.serial_by
  end

  def file_add
    @story = Story.new
  end

  def url_add
    @story = Story.new
  end

  def file_create
    @story = Story.create(story_params.merge(volume_id: params[:vid]))
    @story.set_contents_info(contents_params)
    redirect_to stories_list_path
  end

  def url_create
    @story = Story.create(story_params.merge(volume_id: params[:vid]))
    @story.convert_narou_to_text(contents_params[:url])
    redirect_to stories_list_path
  end

  def edit
  end

  def update
    @story.update_attributes(story_params)
    @story.set_contents_info(contents_params)
    redirect_to stories_list_path
  end

  def active
    @story.toggle_active(is_active: !@story.is_active, serial: 0)
    redirect_to stories_list_path
  end

  private
  def story_params
    params.require(:story).permit(:volume_id, :title, :comment, :is_scene)
  end

  def contents_params
    params.has_key?(:contents) ? params[:contents] : {}
  end

  def get_story
    @story = Story.where(id: params[:sid]).first
  end
end

