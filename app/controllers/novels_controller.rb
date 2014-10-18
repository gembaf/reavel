class NovelsController < ApplicationController
  before_action :get_novel, only: [:edit, :update, :active]

  def list
    @novels = Novel.active_by.updated_by
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
    render "shared/reload"
  end

  def active
    @novel.update(is_active: !@novel.is_active)
    redirect_to novels_list_path
  end

  private
  def novel_params
    params.require(:novel).permit(:title, :mode, :comment, :summary)
  end

  def get_novel
    @novel = Novel.where(id: params[:nid]).first
  end
end

