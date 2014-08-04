class VolumesController < ApplicationController
  def list
    @volumes = get_volumes
    @is_error = Common.error?(params[:error])
  end

  def add
    @volume = Volume.new
  end

  def create
    result = Volume.create(volume_params.merge(part_id: params[:pid]))
    is_success = Common.create_success?(result)
    redirect_to Common.list_path(is_success)
  end

  def edit
    @volume = Volume.where(id: params[:vid]).first
  end

  def update
    volume = Volume.where(id: params[:vid]).first
    is_success = volume.update_attributes(volume_params)
    redirect_to Common.list_path(is_success)
  end

  def active
    volume = Volume.where(id: params[:vid]).first
    is_success = volume.toggle_active(is_active: params[:is_active], serial: 0)
    redirect_to Common.list_path(is_success)
  end

  private
  def volume_params
    params.require(:volume).permit(:part_id, :title, :comment)
  end

  def get_volumes
    Volume.where(part_id: params[:pid]).active_by.serial_by
  end
end

