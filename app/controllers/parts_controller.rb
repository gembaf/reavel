class PartsController < ApplicationController
  def list
    @parts = get_parts
    @is_error = Common.error?(params[:error])
  end

  def add
    @part = Part.new
  end

  def create
    result = Part.create(part_params.merge(chapter_id: params[:cid]))
    is_success = Common.create_success?(result)
    redirect_to Common.list_path(is_success)
  end

  def edit
    @part = Part.where(id: params[:pid]).first
  end

  def update
    part = Part.where(id: params[:pid]).first
    is_success = part.update_attributes(part_params)
    redirect_to Common.list_path(is_success)
  end

  def active
    part = Part.where(id: params[:pid]).first
    is_success = part.toggle_active(is_active: params[:is_active], serial: 0)
    redirect_to Common.list_path(is_success)
  end

  private
  def part_params
    params.require(:part).permit(:chapter_id, :title, :comment)
  end

  def get_parts
    Part.where(chapter_id: params[:cid]).active_by.serial_by
  end
end

