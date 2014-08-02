class MainsController < ApplicationController
  def list
    @novels = Novel.active.updated_by
  end

  def show
  end

  def chapters_index
    @novel = Novel.where(id: params[:nid]).first
    @models = Chapter.where(novel_id: params[:nid]).active.serial_by
    render template: "mains/index"
  end

  def parts_index
    @novel = Novel.where(id: params[:nid]).first
    @models = Part.where(chapter_id: params[:cid]).active.serial_by
    render template: "mains/index"
  end

  def volumes_index
    @novel = Novel.where(id: params[:nid]).first
    @models = Volume.where(part_id: params[:pid]).active.serial_by
    render template: "mains/index"
  end

  def stories_index
    @novel = Novel.where(id: params[:nid]).first
    @models = Story.where(volume_id: params[:vid]).active.serial_by
    render template: "mains/index"
  end
end

