class NovelsController < ApplicationController
  before_action :get_novel, only: [:edit, :update, :active]

  def list
    @novels = Novel.active_by.updated_by
    @is_error = Common.error?(params[:error])
  end

  def add
    @novel = Novel.new
    render "add_edit"
  end

  def create
    @novel = Novel.new(novel_params)
    render :add and return unless @novel.save
    render "shared/reload"
  end

  def edit
    render "add_edit"
  end

  def update
    render :edit and return unless @novel.update(novel_params)
  end

  def active
    is_success = @novel.update_attributes(is_active: params[:is_active])
    redirect_to Common.list_path(is_success)
  end

  private
  def novel_params
    params.require(:novel).permit(:title, :mode, :comment, :summary)
  end

  def get_novel
    @novel = Novel.where(id: params[:nid]).first
  end
end

