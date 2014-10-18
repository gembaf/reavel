class PartsController < ApplicationController
  before_action :get_part, only: [:edit, :update, :active]

  def list
    @parts = Part.where(chapter_id: params[:cid]).active_by.serial_by
  end

  def add
    @part = Part.new
    render "add_edit"
  end

  def create
    @part = Part.new(part_params.merge(chapter_id: params[:cid]))
    render :add and return unless @part.save
    render "shared/reload"
  end

  def edit
    render "add_edit"
  end

  def update
    render :edit and return unless @part.update(part_params)
    render "shared/reload"
  end

  def active
    @part.toggle_active(is_active: !@part.is_active, serial: 0)
    redirect_to parts_list_path
  end

  private
  def part_params
    params.require(:part).permit(:novel_id, :title, :comment)
  end

  def get_part
    @part = Part.where(id: params[:pid]).first
  end
end

