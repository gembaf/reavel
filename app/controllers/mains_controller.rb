class MainsController < ApplicationController
  def show
  end

  def list
    @novels = Novel.active.updated_by
  end

  def chapters_index
    @novel = Novel.where(id: params[:nid]).first
    @chapters = @novel.chapters.active.serial_by
  end

  def parts_index
    @novel = Novel.where(id: params[:nid]).first
    @parts = Part.where(chapter_id: params[:cid]).active.serial_by

    path = skip_path(@parts.first)
    redirect_to path if path.present?
  end

  def volumes_index
    @novel = Novel.where(id: params[:nid]).first
    @volumes = Volume.where(part_id: params[:pid]).active.serial_by
  end

  def stories_index
    @novel = Novel.where(id: params[:nid]).first
    @stories = Story.where(volume_id: params[:vid]).active.serial_by
  end

  private
  def skip_path(part)
    return nil if part.nil?

    volume = part.volumes.first
    return nil if volume.nil?

    if @novel.mode == Novel::MODE_MIDDLE
      return mains_volumes_path(cid: params[:cid], pid: part.id)
    elsif @novel.mode == Novel::MODE_SHORT
      return mains_stories_path(pid: part.id, vid: volume.id)
    end
  end
end

