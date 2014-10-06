class VolumesController < ApplicationController
  before_action :get_volume, only: [:edit, :update, :active]

  def list
    @volumes = Volume.where(part_id: params[:pid]).active_by.serial_by
    @is_error = Common.error?(params[:error])
  end

  def add
    @volume = Volume.new
    render "add_edit"
  end

  def create
    @volume = Volume.new(volume_params.merge(part_id: params[:pid]))
    render :add and return unless @volume.save
    render "shared/reload"
  end

  def edit
    render "add_edit"
  end

  def update
    render :edit and return unless @volume.update(volume_params)
    render "shared/reload"
  end

  def active
    is_success = @volume.toggle_active(is_active: params[:is_active], serial: 0)
    redirect_to Common.list_path(is_success)
  end

  private
  def volume_params
    params.require(:volume).permit(:novel_id, :title, :comment)
  end

  def get_volume
    @volume = Volume.where(id: params[:vid]).first
  end
end

