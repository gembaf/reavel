class NovelsController < ApplicationController
  def list
    @novels = get_novels
    @is_error = Common.error?(params[:error])
  end

  def add
    @novel = Novel.new
  end

  def create
    result = Novel.create(novel_params)
    is_success = Common.create_success?(result)
    redirect_to Common.list_path(is_success)
  end

  def edit
    @novel = Novel.where(id: params[:nid]).first
  end

  def update
    novel = Novel.where(id: params[:nid]).first
    is_success = novel.update_attributes(novel_params)
    redirect_to Common.list_path(is_success)
  end

  def active
    novel = Novel.where(id: params[:nid]).first
    is_success = novel.update_attributes(is_active: params[:is_active])
    redirect_to Common.list_path(is_success)
  end

  private
  def novel_params
    params.require(:novel).permit(:title, :mode, :comment, :summary)
  end

  def get_novels
    Novel.active_by.updated_by
  end
end

