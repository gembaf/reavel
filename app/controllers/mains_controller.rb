class MainsController < ApplicationController
  before_action :current_novel, only: [:show, :stories, :volumes, :parts, :chapters]

  def list
    @novels = Novel.updated_by
  end

  def show
    @story = current_story
  end

  def chapters
    @chapters = @current[:novel].chapters
  end

  def parts
    chapter = current_chapter
    @parts = chapter.parts
    path = skip_path(@parts.first)
    redirect_to path if path
  end

  def volumes
    part = current_part
    @volumes = part.volumes
  end

  def stories
    volume = current_volume
    @stories = volume.stories
  end

  private
  def current_novel
    @current = {}
    @current[:novel] = Novel.where(id: session[:nid]).includes(chapters: {parts: {volumes: :stories}}).first if session[:nid]
  end

  def current_chapter
    @current[:chapter] = @current[:part].chapter if @current[:part]
    @current[:chapter] = Chapter.where(id: params[:cid]).first if params[:cid]
    @current[:chapter]
  end

  def current_part
    @current[:part] = @current[:volume].part if @current[:volume]
    @current[:part] = Part.where(id: params[:pid]).first if params[:pid]
    current_chapter
    @current[:part]
  end

  def current_volume
    @current[:volume] = @current[:story].volume if @current[:story]
    @current[:volume] = Volume.where(id: params[:vid]).first if params[:vid]
    current_part
    @current[:volume]
  end

  def current_story
    @current[:story] = Story.where(id: params[:sid]).first if params[:sid]
    current_volume
    @current[:story]
  end

  def skip_path(part)
    if @current[:novel].mode == Novel::MODE_LONG
      return nil
    elsif @current[:novel].mode == Novel::MODE_MIDDLE
      return mains_volumes_path(pid: part.id)
    else    # mode == MODE_SHORT
      return mains_stories_path(vid: part.volumes.first.id)
    end
  end
end

