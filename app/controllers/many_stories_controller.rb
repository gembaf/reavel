class ManyStoriesController < ApplicationController
  def add
    @volume = Volume.new
    @volume.build_stories
  end

  def create
    stories_params.each do |val|
      break if Common.skip?(val)
      val[:volume_id] = params[:vid]
      contents_params = {file: val.delete(:contents)}
      story = Story.create(val)
      story.set_contents_info(contents_params)
    end
    redirect_to stories_list_path
  end

  def edit
    @volume = Volume.where(id: params[:vid]).first
  end

  def update
    stories_params.each do |val|
      story = Story.where(id: val[:id]).first
      val.delete(:id)
      contents_params = {file: val.delete(:contents)}
      story.update_attributes(val)
      story.set_contents_info(contents_params) if contents_params[:file].present?
    end
    redirect_to stories_list_path
  end

  private
  def stories_params
    params.require(:volume).require(:stories_attributes).values
  end
end

