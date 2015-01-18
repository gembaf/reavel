class ManyStoriesController < ApplicationController
  def file_add
    @volume = Volume.new
    @volume.build_stories
  end

  def url_add
    @volume = Volume.new
    @volume.build_stories
  end

  def file_create
    stories_params.each do |val|
      break unless val[:contents]
      val[:volume_id] = params[:vid]
      contents_params = {file: val.delete(:contents)}
      story = Story.create(val)
      story.set_contents_info(contents_params)
    end
    redirect_to stories_list_path
  end

  def url_create
    stories_params.each do |val|
      break if val[:contents].blank?
      val[:volume_id] = params[:vid]
      url = val.delete(:contents)
      story = Story.create(val)
      story.convert_narou_to_text(url)
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
    end
    redirect_to stories_list_path
  end

  private
  def stories_params
    params.require(:volume).require(:stories_attributes).values
  end
end

