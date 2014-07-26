class NovelsController < ApplicationController
  def list
    @novels = Novel.all.updated_by
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
    @novel = Novel.where(id: params[:id]).first
  end

  def update
    novel = Novel.where(id: params[:id]).first
    is_success = novel.update_attributes(novel_params)
    redirect_to Common.list_path(is_success)
  end

  def active
    novel = Novel.where(id: params[:id]).first
    is_success = novel.update_attributes(is_active: params[:is_active])
    redirect_to Common.list_path(is_success)
  end

  private
  def novel_params
    params.require(:novel).permit(:title, :mode, :comment, :summary)
  end
end

