class ChaptersController < ApplicationController
  before_action :get_chapter, only: [:edit, :update, :active]

  def list
    @chapters = Chapter.where(novel_id: params[:nid]).active_by.serial_by
    @is_error = Common.error?(params[:error])
  end

  def add
    @chapter = Chapter.new
    render "add_edit"
  end

  def create
    @chapter = Chapter.new(chapter_params.merge(novel_id: params[:nid]))
    render :add and return unless @chapter.save
    render "shared/reload"
  end

  def edit
    render "add_edit"
  end

  def update
    render :edit and return unless @chapter.update(chapter_params)
    render "shared/reload"
  end

  def active
    is_success = @chapter.toggle_active(is_active: params[:is_active], serial: 0)
    redirect_to Common.list_path(is_success)
  end

  private
  def chapter_params
    params.require(:chapter).permit(:novel_id, :title, :comment)
  end

  def get_chapter
    @chapter = Chapter.where(id: params[:cid]).first
  end
end

