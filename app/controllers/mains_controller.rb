class MainsController < ApplicationController
  before_action :current_novel, only: [:show, :stories, :volumes, :parts, :chapters]
  #before_action :current_story, only: [:show, :stories, :volumes, :parts, :chapters]
  #before_action :current_volume, only: [:show, :stories, :volumes, :parts, :chapters]
  #before_action :current_part, only: [:show, :stories, :volumes, :parts, :chapters]
  #before_action :current_chapter, only: [:show, :stories, :volumes, :parts, :chapters]

  def list
    @novels = Novel.active.updated_by
  end

  def show
    @story = @current[:story]
  end

  def chapters
    @chapters = Chapter.where(novel_id: params[:nid])
  end

  def parts
    @parts = Part.where(chapter_id: params[:cid])
    path = skip_path(@parts.first)
    redirect_to path if path
  end

  def volumes
    @volumes = Volume.where(part_id: params[:pid])
  end

  def stories
    @stories = Story.where(volume_id: params[:vid])
  end

  private
  def current_novel
    @current = {}
    session[:nid] = params[:nid] if params[:nid]
    @current[:novel] = Novel.where(id: session[:nid]).includes(chapters: {parts: {volumes: :stories}}).first if session[:nid]
  end

  def current_chapter
    @current[:chapter] = @current[:part].chapter if @current[:part]
    @current[:chapter] = Chapter.where(id: params[:cid]).first if params[:cid]
  end

  def current_part
    @current[:part] = @current[:volume].part if @current[:volume]
    @current[:part] = Part.where(id: params[:pid]).first if params[:pid]
  end

  def current_volume
    @current[:volume] = @current[:story].volume if @current[:story]
    @current[:volume] = Volume.where(id: params[:vid]).first if params[:vid]
  end

  def current_story
    @current[:story] = Story.where(id: params[:sid]).first if params[:sid]
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

