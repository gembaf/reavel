class ManyStoriesController < ApplicationController
  def list
    redirect_to stories_list_path
  end

  def add
    @volume = Volume.new
    @volume.build_stories
  end

  def create
    results = []
    stories_params.each do |val|
      break if Common.skip?(val)
      val[:volume_id] = params[:vid]
      contents_params = {file: val.delete(:contents)}

      results << Story.create(val)
      is_success = Common.create_success?(results.last)
      results.last.set_contents_info(contents_params) if is_success
    end

    is_success = Common.many_create_success?(results)
    redirect_to Common.list_path(is_success)
  end

  def edit
    @volume = Volume.where(id: params[:vid]).first
  end

  def update
    results = []
    stories_params.each do |val|
      story = Story.where(id: val[:id]).first
      val.delete(:id)
      contents_params = {file: val.delete(:contents)}
      results << story.update_attributes(val)
      story.set_contents_info(contents_params) if results.last && contents_params[:file].present?
    end

    redirect_to Common.list_path(results.all?)
  end

  private
  def stories_params
    params.require(:volume).require(:stories_attributes).values
  end
end

