class ChaptersController < ApplicationController
  def list
    @chapters = get_chapters
    @is_error = Common.error?(params[:error])
  end

  def add
    @chapter = Chapter.new
  end

  def create
    result = Chapter.create(chapter_params)
    is_success = Common.create_success?(result)

    redirect_to Common.list_path(is_success, params[:id])
  end

  def edit
    @chapter = Chapter.where(id: params[:id]).first
  end

  def update
    chapter = Chapter.where(id: params[:id]).first
    is_success = chapter.update_attributes(chapter_params)
    redirect_to Common.list_path(is_success, chapter.novel_id)
  end

  def active
    chapter = Chapter.where(id: params[:id]).first
    is_success = chapter.update_attributes(is_active: params[:is_active])
    redirect_to Common.list_path(is_success)
  end

  private
  def chapter_params
    params.require(:chapter).permit(:novel_id, :title, :comment)
  end

  def get_chapters
    return Chapter.all if params[:id].nil?
    Chapter.where(novel_id: params[:id])
  end
end

